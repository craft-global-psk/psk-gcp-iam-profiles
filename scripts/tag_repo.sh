#!/usr/bin/env bash
export SEM_VER_UPGRADE_PART=$1

export CURRENT_TAG=$(git describe --tags --abbrev=0)
export PATTERN="^v?(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)"


declare MAJOR=0
declare MINOR=0
declare PATCH=1

if [[ "${CURRENT_TAG}" =~ ${PATTERN} ]]; then
    case "${SEM_VER_UPGRADE_PART}" in
        major) MAJOR="$((BASH_REMATCH[1]+1))";  MINOR="0";                      PATCH="0" ;;
        minor) MAJOR="${BASH_REMATCH[1]}";      MINOR="$((BASH_REMATCH[2]+1))"; PATCH="0" ;;
        patch) MAJOR="${BASH_REMATCH[1]}";      MINOR="${BASH_REMATCH[2]}";     PATCH="$((BASH_REMATCH[3]+1))" ;;
        *) MAJOR="${BASH_REMATCH[1]}";          MINOR="${BASH_REMATCH[2]}";     PATCH="${BASH_REMATCH[3]}";;
    esac
fi

NEW_VER="v${MAJOR}.${MINOR}.${PATCH}"

git tag $NEW_VER
