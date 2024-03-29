//+------------------------------------------------------------------+
//| function : LoopPositions -> void                                 |
//|                                                                  |
//| [DESCRIPTION]                                                    |
//| Realiza a leitura de dados das posições da conta.                |
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
void LoopPositions(ulong magic, string symbol)
  {
   //--- Obtem a quantidade total de posições abertas
   int positions_total = PositionsTotal();
   
   //--- Realizo um loop em todas as posições
   for(int i=positions_total-1;i>=0;i--)
     {
      //--- Obtenho o ticket da posição
      ulong position_ticket = PositionGetTicket(i);
      
      //--- Seleciono a posição pelo ticket
      if(PositionSelectByTicket(position_ticket))
        {
         //--- Obtenho dados da posição de número mágico e símbolo
         ulong position_magic = PositionGetInteger(POSITION_MAGIC);
         string position_symbol = PositionGetString(POSITION_SYMBOL);
         
         //--- Verificando se a posição é referente ao meu EA
         if(position_magic == magic && position_symbol == symbol)
           {
            /*
            
            Aqui basta trabalhar com os dados utilizando as seguintes
            funções e suas propriedades:
            - PositionGetDouble();
            - PositionGetInteger();
            - PositionGetString();
            
            */
           }
        }
     }
  }
//+------------------------------------------------------------------+