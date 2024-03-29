//+------------------------------------------------------------------+
//| Inputs                                                           |
//+------------------------------------------------------------------+
input int                  InpMAPeriod          = 21;                // Período
input ENUM_TIMEFRAMES      InpMaTimeframe       = PERIOD_CURRENT;    // Timeframe
input int                  InpMaShift           = 0;                 // Deslocamento
input ENUM_MA_METHOD       InpMaMethod          = MODE_SMA;          // Tipo de cálculo
input ENUM_APPLIED_PRICE   InpMaAppliedPrice    = PRICE_CLOSE;       // Preço aplicado


//+------------------------------------------------------------------+
//| Variáveis globais                                                |
//+------------------------------------------------------------------+
int handle_ma;       // Armazena o handle do indicador
double buffer_ma[];  // Armazena os dados do indicador
string name;         // Armazena o nome do indicador

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
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
   name = ChartIndicatorName(0,0,ChartIndicatorsTotal(0,0)-1);
   
   //--- Sucesso na inicialização
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+



//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   //--- Apaga indicador do gráfico pelo nome
   ChartIndicatorDelete(0,0,name);
  }
//+------------------------------------------------------------------+



//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
   //--- Quantidade de dados a serem copiados
   int ammount_data = 2;
   
   //--- Realiza a copia
   int size = CopyBuffer(handle_ma,0,0,ammount_data,buffer_ma);
   
   //--- Verifica se os dados foram copiados corretamente
   if(size == ammount_data)
     {
      //--- Exibe o nome do indicador e seu valor atual
      Print(name," - ",buffer_ma[0]);
     }
  }
//+------------------------------------------------------------------+