//+------------------------------------------------------------------+
//| Inputs                                                           |
//+------------------------------------------------------------------+
input group                "Indicador | Média Móvel (MA)"
input int                  InpMAPeriod          = 21;                // Período
input ENUM_TIMEFRAMES      InpMaTimeframe       = PERIOD_CURRENT;    // Timeframe
input int                  InpMaShift           = 0;                 // Deslocamento
input ENUM_MA_METHOD       InpMaMethod          = MODE_SMA;          // Tipo de cálculo
input ENUM_APPLIED_PRICE   InpMaAppliedPrice    = PRICE_CLOSE;       // Preço aplicado
input group                "Indicador | Índice de Força Relativo (IFR)"
input int                  InpIFRPeriod         = 2;                 // Período
input ENUM_TIMEFRAMES      InpIFRTimeframe      = PERIOD_CURRENT;    // Timeframe
input ENUM_APPLIED_PRICE   InpIFRAppliedPrice   = PRICE_CLOSE;       // Preço aplicado
input double               InpIFROversold       = 30;                // Sobrevendido
input double               InpIFROverbought     = 70;                // Sobrecomprado


//+------------------------------------------------------------------+
//| Variáveis globais                                                |
//+------------------------------------------------------------------+
int handle_ma;       // Armazena o handle do indicador
double buffer_ma[];  // Armazena os dados do indicador
string name_ma;      // Armazena o nome do indicador
int handle_ifr;      // Armazena o handle do indicador
double buffer_ifr[]; // Armazena os dados do indicador
string name_ifr;     // Armazena o nome do indicador


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   //+------------------------------------------------------------------+
   //| Média Móvel                                                      |
   //+------------------------------------------------------------------+
   //--- Inverte a indexação
   ArraySetAsSeries(buffer_ma,true);
   
   //--- Cria indicador média móvel, e armazena resultado no handle
   handle_ma = iMA(_Symbol,InpMaTimeframe,InpMAPeriod,InpMaShift,InpMaMethod,InpMaAppliedPrice);
   
   //--- Verifica se indicador foi criado com sucesso
   if(handle_ma == INVALID_HANDLE)
     {
      //--- Erro
      Print(">>> [!] ERRO: Falha ao criar indicador média móvel!");
      return(INIT_FAILED);
     }
   else
     {
      //--- Exibe indicador no gráifco
      ChartIndicatorAdd(0,0,handle_ma);
     }
   
   //--- Obtem o nome o indicador
   name_ma = ChartIndicatorName(0,0,ChartIndicatorsTotal(0,0)-1);
   
   //+------------------------------------------------------------------+
   //| Índice de Força Relativo                                         |
   //+------------------------------------------------------------------+
   //--- Inverte a indexação
   ArraySetAsSeries(buffer_ifr,true);
   
   //--- Cria indicador média móvel, e armazena resultado no handle
   handle_ifr = iRSI(_Symbol,InpIFRTimeframe,InpIFRPeriod,InpIFRAppliedPrice);
   
   //--- Verifica se indicador foi criado com sucesso
   if(handle_ifr == INVALID_HANDLE)
     {
      //--- Erro
      Print(">>> [!] ERRO: Falha ao criar indicador IFR!");
      return(INIT_FAILED);
     }
   else
     {
      //--- Exibe indicador no gráifco
      ChartIndicatorAdd(0,1,handle_ifr);
     }
   
   //--- Obtem o nome o indicador
   name_ifr = ChartIndicatorName(0,1,ChartIndicatorsTotal(0,1)-1);
   
   //--- Sucesso na inicialização
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   //--- Apaga indicador MA
   ChartIndicatorDelete(0,0,name_ma);
   
   //--- Apaga indicador IFR
   ChartIndicatorDelete(0,1,name_ifr);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick(void)
  {
   //--- Atualiza dados dos indicadores
   if(!UpdateIFR() || !UpdateMA())
     {
      Print("Falha ao obter dados dos indicadores");
     }
   
   //--- Verificamos sinal
   int signal = CheckSignal();
   
   if(signal == 1)
     {
      Print("Compra");
     }
   if(signal == -1)
     {
      Print("Venda");
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool UpdateIFR(void)
  {
   //--- Quantidade de dados a serem copiados
   int ammount_data = 2;
   
   //--- Realiza a copia
   int size = CopyBuffer(handle_ifr,0,0,ammount_data,buffer_ifr);
   
   //--- Retorna true em caso de sucesso na atualização
   return(size == ammount_data);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool UpdateMA(void)
  {
   //--- Quantidade de dados a serem copiados
   int ammount_data = 2;
   
   //--- Realiza a copia
   int size = CopyBuffer(handle_ma,0,0,ammount_data,buffer_ma);
   
   //--- Retorna true em caso de sucesso na atualização
   return(size == ammount_data);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int CheckSignal(void)
  {
   //--- Obtem valores dos indicadores e dos preços
   double ifr = buffer_ifr[0];
   double ma = buffer_ma[0];
   double ask = SymbolInfoDouble(_Symbol,SYMBOL_ASK);
   double bid = SymbolInfoDouble(_Symbol,SYMBOL_BID);
   
   //--- Condição de compra
   if(ifr < InpIFROversold && ask > ma)
     {
      return(1);
     }
   
   //--- Condição de venda
   if(ifr > InpIFROverbought && bid < ma)
     {
      return(-1);
     }
   
   //--- Neutro
   return(0);
  }