alias lb='ledger balance -f'
alias lbas='ledger -M balance ^assets -f'
alias lbbs='ledger -M balance ^assets ^liabilities -f'
alias lbexcm='ledger bal expenses --period "this month" -f'
alias lbexlm='ledger bal expenses --period "last month" -f'
alias lbin='ledger -M balance ^income -f'
alias lbpl='ledger -M balance ^income ^expenses -f'
alias le='ledger equity -f'
alias lrli='ledger -M register ^liabilities -f'
alias lem="ledger reg ^expenses --period-sort '(amount)' -M --begin 2022/06/01 -f Denbrige.ledger --display 'account=~/DL/' --wide"

print_dates_last_12_months() {
  local file_name="$1"

  if [[ -z "$file_name" ]]; then
    echo "Error: file_name is an empty string."
    return 1
  fi
  if [[ ! -f "$file_name" ]]; then
    echo "Error: file '$file_name' does not exist."
    return 1
  fi
  for ((i=1; i<=12; i++)); do
    # Calculate the first day of the month
    first_day=$(date -v-"$i"m -v1d +%Y-%m-01)
    # Calculate the last day of the month
    last_day=$(date -v-"$i"m -v1d -v+1m -v-1d +%Y-%m-%d)

    echo "First day: $first_day, Last day: $last_day"
  done
}

print_dates_last_12_months
