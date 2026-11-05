#!/bin/sh
# Claude Code statusLine command
# Converted from Powerlevel10k Pure-style prompt (~/.p10k.zsh)
#
# P10k left segments: dir (blue), vcs (grey), prompt_char (stripped)
# P10k right segments: time (grey, 12h format)
#
# Additional: model name, context window usage from Claude Code session data

input=$(cat)

# -- Claude Code session data --
model=$(echo "$input" | jq -r '.model.display_name // empty')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
session_name=$(echo "$input" | jq -r '.session_name // empty')

# -- Git info (mirrors p10k vcs segment) --
git_info=""
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  branch=$(git -c core.fsmonitor= --no-optional-locks symbolic-ref --short HEAD 2>/dev/null \
    || git -c core.fsmonitor= --no-optional-locks rev-parse --short HEAD 2>/dev/null)
  dirty=""
  if ! git -c core.fsmonitor= --no-optional-locks diff --quiet HEAD -- 2>/dev/null \
    || [ -n "$(git -c core.fsmonitor= --no-optional-locks ls-files --others --exclude-standard 2>/dev/null | head -1)" ]; then
    dirty="*"
  fi
  git_info="${branch}${dirty}"
fi

# -- Build output --
# Directory (blue, ANSI 34), git (grey, ANSI 90), session info (grey)
parts=""

# Directory -- basename like Pure
dir=$(basename "$(pwd)")
parts=$(printf '\033[34m%s\033[0m' "$dir")

# Git branch + dirty indicator
if [ -n "$git_info" ]; then
  parts=$(printf '%s \033[90m%s\033[0m' "$parts" "$git_info")
fi

# Session name if set
if [ -n "$session_name" ]; then
  parts=$(printf '%s \033[90m(%s)\033[0m' "$parts" "$session_name")
fi

# Model + context usage
meta=""
[ -n "$model" ] && meta="$model"
if [ -n "$used" ]; then
  meta="${meta:+$meta }ctx:$(printf '%.0f' "$used")%"
fi
if [ -n "$meta" ]; then
  parts=$(printf '%s \033[90m· %s\033[0m' "$parts" "$meta")
fi

# Time (grey, 12h format like p10k TIME_FORMAT '%D{%I:%M:%S %p}')
current_time=$(date +'%I:%M:%S %p')
parts=$(printf '%s \033[90m%s\033[0m' "$parts" "$current_time")

printf '%s' "$parts"
