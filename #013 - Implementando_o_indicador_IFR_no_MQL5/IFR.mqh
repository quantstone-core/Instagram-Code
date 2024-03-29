//+------------------------------------------------------------------+
//| Inputs                                                           |
//+------------------------------------------------------------------+
input int                  InpIFRPeriod         = 2;                 // Período
input ENUM_TIMEFRAMES      InpIFRTimeframe      = PERIOD_CURRENT;    // Timeframe
input ENUM_APPLIED_PRICE   InpIFRAppliedPrice   = PRICE_CLOSE;       // Preço aplicado
input double               InpIFROversold       = 30;                // Sobrevendido
input double               InpIFROverbought     = 70;                // Sobrecomprado


//+------------------------------------------------------------------+
//| Variáveis globais                                                |
//+------------------------------------------------------------------+
int handle_ifr;      // Armazena o handle do indicador
double buffer_ifr[]; // Armazena os dados do indicador
string name;         // Armazena o nome do indicador

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
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
   name = ChartIndicatorName(0,1,ChartIndicatorsTotal(0,1)-1);
   
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
   ChartIndicatorDelete(0,1,name);
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
   int size = CopyBuffer(handle_ifr,0,0,ammount_data,buffer_ifr);
   
   //--- Verifica se os dados foram copiados corretamente
   if(size == ammount_data)
     {
      //--- Verifica nível sobrevendido
      if(buffer_ifr[0] < InpIFROversold)
        {
         //--- Exibe o seu valor atual
         Print("Nível sobrevendido atingido! - ",DoubleToString(buffer_ifr[0],2));
        }
      if(buffer_ifr[0] > InpIFROverbought)
        {
         //--- Exibe o seu valor atual
         Print("Nível sobrecomprado atingido! - ",DoubleToString(buffer_ifr[0],2));
        }
     }
  }
//+------------------------------------------------------------------+