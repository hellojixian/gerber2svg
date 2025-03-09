#!/bin/bash

# 检查是否提供了输入路径
if [ -z "$1" ]; then
    echo "用法: $0 <输入目录>"
    exit 1
fi

INPUT_DIR="$1"

# 检查输入路径是否有效
if [ ! -d "$INPUT_DIR" ]; then
    echo "错误: 指定的目录不存在: $INPUT_DIR"
    exit 1
fi

# 创建输出目录
OUTPUT_DIR="$INPUT_DIR/SVGFiles"
mkdir -p "$OUTPUT_DIR"

# 遍历目录中的所有 .gbr 文件
for gbr_file in "$INPUT_DIR"/GerberFiles/*.gbr; do
    # 检查是否匹配到文件
    if [ ! -f "$gbr_file" ]; then
        echo "未找到 .gbr 文件"
        exit 1
    fi

    # 获取文件名（不带扩展名）
    filename=$(basename -- "$gbr_file" .gbr)

    # 转换为 .svg
    gerbv "$gbr_file" -x svg -o "$OUTPUT_DIR/$filename.svg"

    if [ $? -eq 0 ]; then
        echo "转换成功: $gbr_file -> $OUTPUT_DIR/$filename.svg"
    else
        echo "转换失败: $gbr_file"
    fi
done

for drill_file in "$INPUT_DIR"/DrillFiles/*.xln; do
  gerbv "$drill_file" -x svg -o "$OUTPUT_DIR/$filename.svg"
  if [ $? -eq 0 ]; then
        echo "转换成功: $drill_file -> $OUTPUT_DIR/$filename.svg"
    else
        echo "转换失败: $drill_file"
    fi
done

echo "所有转换任务完成。SVG 文件保存在: $OUTPUT_DIR"
