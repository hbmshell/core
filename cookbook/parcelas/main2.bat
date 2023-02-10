@echo off
REM Example 2
REM
REM Primeira parcela no mesmo mês / First installment in the same month

REM Data da compra / Date of purchase : -dtcompra
REM Dia do vencimento da fatura do cartão de crédito / Credit card due date : -diavenc
REM Quantidade de dias a subtrair do vencimento para obter o melhor dia / Number of days to subtract from due date to get the best day : -qtddias
REM Qtd. Parcelas / Number of installments : -parcelas

hbmscript main.prg -dtcompra 2022-12-01 -diavenc 12 -qtddias 5 -parcelas 10  --pause-after