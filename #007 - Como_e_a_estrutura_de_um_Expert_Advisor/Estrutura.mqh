//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   //--- Verificação de parâmetros
   if(periodo_media < 0)
     {
      Print(">>> [!] ERRO: Parâmetro de período da média inválido!");
      return(INIT_FAILED);
     }
   
   //--- Inserir indicadores...
   
   //--- Sucesso na inicialização
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+



//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   //--- Remover indicadores...
   ChartIndicatorDelete(0,0,name);
  }
//+------------------------------------------------------------------+



//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
   //--- Caso candle de alta
   if(iClose(_Symbol,_Period,1) > iOpen(_Symbol,_Period,1))
     {
      //--- Envia ordem de compra
      trade.Buy(1,_Symbol);
     }
   
   //--- Caso candle de baixa
   if(iClose(_Symbol,_Period,1) < iOpen(_Symbol,_Period,1))
     {
      //--- Envia ordem de venda
      trade.Sell(1,_Symbol);
     }
  }
//+------------------------------------------------------------------+