@echo off
@echo Example 1
@echo
@echo Primeira parcela no outro mês / First installment in another month
@echo

@echo Data da compra / Date of purchase :===> -dtcompra
@echo Dia do vencimento da fatura do cartão de crédito / Credit card due date :===> -diavenc
@echo Quantidade de dias a subtrair do vencimento para obter o melhor dia / Number of days to subtract from due date to get the best day :===> -qtddias
@echo Qtd. Parcelas / Number of installments :===> -parcelas

hbmscript main.prg -dtcompra 2022-12-09 -diavenc 12 -qtddias 5 -parcelas 10  --pause-after