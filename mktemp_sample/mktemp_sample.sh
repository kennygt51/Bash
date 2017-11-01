#!/bin/bash
# 一時ファイル検証(mktempバージョン)

function write_printf {
  printf '%s\n' "sleep 10を実行後に${1}と一時ファイルに書き込み"
  sleep 10
  printf '%s\n' "${1}" > "${TMP_FILE}"
}

function receive_trap {
  printf '%s\n' "SIGINITトラップを受信"
  rm -f "${TMP_FILE}"
}

trap receive_trap SIGINT

TMP_DIR='/tmp'
TMP_FILE=$(mktemp ${TMP_DIR}/mktemp_test.XXX)

if [ "${#}" -ne  1 ]; then
  printf '%s\n' "引数エラー"
  rm -f "${TMP_FILE}"
  exit 0
fi

write_printf "${1}"
cat "${TMP_FILE}"

rm -f "${TMP_FILE}"

exit 0
