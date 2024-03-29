//                                  +------------------------------+---------+
//                                  | Descrição                    | Memória |
//                                  +------------------------------+---------+
char      charValue = 12;        // | Números inteiros             | 1 byte  |
uchar     positiveInt = 12;      // | Números inteiros positivos   | 1 byte  |
int       integerValue = 12;     // | Números inteiros             | 4 bytes |
uint      positiveInteger = 12;  // | Números inteiros positivos   | 4 bytes |
long      longValue = 123456;    // | Números inteiros             | 8 bytes |
ulong     positiveLong = 123456; // | Números inteiros positivos   | 8 bytes |
double    decimalValue = 3.14;   // | Números decimais             | 8 bytes |
string    text = "Mensagem";     // | Para textos                  | -       |
//                                  +------------------------------+---------+


//+------------------------------------------------------------------+
//| Operadores Condicionais                                          |
//+------------------------------------------------------------------+
if(ifr < 30)
  {
   // Deve comprar
  }
else if(ifr > 70)
  {
   // Deve vender
  }
else
  {
   // Dsperando sinal
  }

//+------------------------------------------------------------------+
//| Arrays                                                           |
//+------------------------------------------------------------------+
double array[5] = { 1.0, 2.0, 3.0, 4.0, 5.0 };   // Criar array com 5 posições
Print(array[2]);                       // Imprime o dado da posição 2
array[2] = 2.5;                        // Altera valor da posição 2 para '2.5'
Print(array[2]);                       // Imprime novamente o dado da posição 2


//+------------------------------------------------------------------+
//| Funções                                                          |
//+------------------------------------------------------------------+
string VerificarSinal()
  {
   if(ifr < 30)
     {
      return("Compra");
     }
   else if(ifr > 70)
     {
      return("Venda");
     }
   else
     {
      return("Sem sinal");
     }
  }