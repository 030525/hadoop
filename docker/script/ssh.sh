#!/usr/bin/bash
set +x
# 检查参数是否足够
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <ssh_ip> <command>"
    exit 1
fi

# 从参数中获取SSH的IP和要执行的命令
ssh_ip=$1
command_to_run="${*:2}"

# 执行SSH命令
ssh "$ssh_ip" "$command_to_run"