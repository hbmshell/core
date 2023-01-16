@echo off
@echo Example 2
@echo
@echo Primeira parcela no mesmo mês / First installment in the same month
@echo

@echo Data da compra / Date of purchase :===> -dtcompra
@echo Dia do vencimento da fatura do cartão de crédito / Credit card due date :===> -diavenc
@echo Quantidade de dias a subtrair do vencimento para obter o melhor dia / Number of days to subtract from due date to get the best day :===> -qtddias
@echo Qtd. Parcelas / Number of installments :===> -parcelas

hbmscript main.prg -dtcompra 2022-12-01 -diavenc 12 -qtddias 5 -parcelas 10  --pause-after