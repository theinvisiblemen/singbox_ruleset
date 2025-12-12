#!/bin/bash

# 设置基础目录
base_dir="ruleset"

# 递归查找所有 .json 文件并编译
find "$base_dir" -type f -name "*.json" | while read -r json_file; do
    # 获取目录路径
    dir=$(dirname "$json_file")
    
    # 获取文件名（不含扩展名）
    filename=$(basename "$json_file" .json)
    
    # 构建输出文件路径
    output_file="$dir/$filename.srs"
    
    # 执行 sing-box 编译命令
    sing-box rule-set compile --output "$output_file" "$json_file"
    
    # 输出处理信息
    if [[ $? -eq 0 ]]; then
        echo "✓ Compiled: $json_file -> $output_file"
    else
        echo "✗ Failed: $json_file"
    fi
done

echo ""
echo "Compilation complete!"
