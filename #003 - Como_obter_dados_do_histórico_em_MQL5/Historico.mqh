//+------------------------------------------------------------------+
//| function : LoopHistory -> void                                   |
//|                                                                  |
//| [DESCRIPTION]                                                    |
//| Realiza a leitura de dados do histórico de operações da conta.   |
//|                                                                  |
//| [INPUT]                                                          |
//| +-- type --+---- name ----+----------- description ------------+ |
//| | ulong    | magic        | Número mágico do EA                | |
//| | string   | symbol       | Símbolo do EA                      | |
//| +----------+--------------+------------------------------------+ |
//|                                                                  |
//| [OUTPUT]                                                         |
//| Sem retorno.                                                     |
//|                                                                  |
//+------------------------------------------------------------------+
void LoopHistory(ulong magic, string symbol)
  {
   //--- Datas de inicio e fim
   datetime time_from = D'2022.01.01 00:00:00';
   datetime time_to = D'2023.01.01 00:00:00';
   
   //--- Seleciona o histórico por datas
   HistorySelect(time_from,time_to);
   
   //--- Obtenho o total do período
   int history_total = HistoryDealsTotal();
   
   //--- Realizo um loop em todas as operações
   for(int i=history_total-1;i>=0;i--)
     {
      //--- Obtenho o ticket da operação
      ulong history_ticket = HistoryDealGetTicket(i);
      
      //--- Obtenho dados da operação de número mágico e símbolo
      ulong history_magic = HistoryDealGetInteger(history_ticket,DEAL_MAGIC);
      string history_symbol = HistoryDealGetString(history_ticket,DEAL_SYMBOL);
      
      //--- Verificando se a operação é referente ao meu EA
      if(history_magic == magic && history_symbol == symbol)
        {
         /*
         
         Aqui basta trabalhar com os dados utilizando as seguintes
         funções e suas propriedades:
         - HistoryDealGetDouble();
         - HistoryDealGetInteger();
         - HistoryDealGetString();
         
         */
        }
     }
  }
//+------------------------------------------------------------------+