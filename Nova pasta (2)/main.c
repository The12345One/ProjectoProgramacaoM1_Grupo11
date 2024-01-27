#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <locale.h>
//PARA STRINGS
//char s[20]
//scanf("%19[^\n]s", s)
//fgets(s, 20, stdin)
//gets(vetor) - vai recebr a string aumentando o tamanho do vetor
//puts(vetor) - imprime a string completa dentro do vetor
//fflush(stdin);
//strcpy(destino, origem) - para alterar o valor de uma string (biblioteca string.h)
//strcat(destino, origem) - permite juntar duas trings, a outra pode estar entre "string"
//strlen(string) - tamanho da string
//strcmp(str1, str2) - compara as strings se são identicas retorna 0
// typedef struct pessoa pessoa;
// A R M A Z E N A M E N T O  I N T E R N O  -  S T R U C T S 
struct pessoa {
	int codigo;
	char nome[200];
	char bi[200];
	int nif;
	int telefone;	
};
typedef struct pessoa pessoa;
pessoa clientes[100000];
struct conta {
	int codigo;
	int codigo_cliente;
	int numero_conta;
	int estado;
	int tipo_conta;
	float saldo;	
};
typedef struct conta conta;
conta contas[100000];
// F I M  A R M A Z E N A M E N T O

// C A D A S T R O  D E  C L I E N T E 
int clienteC = 0;
int cadastro_de_cliente(pessoa p){
	
	clientes[clienteC].codigo = clienteC;
	strcpy(clientes[clienteC].nome, p.nome);
	if(strlen(p.bi) == 0){
		clientes[clienteC].nif = p.nif;	
	}else{
		strcpy(clientes[clienteC].bi, p.bi);
	}    
	clientes[clienteC].telefone = p.telefone;
	clienteC = clienteC + 1;
	//return true;
}

// F I M  C A D A S T R O

// A C T U A L I Z A R  D A D O S  D O  C L I E N T E 
int actualizacao_dos_dados(pessoa p){
	
	strcpy(clientes[p.codigo].nome, p.nome);
	if(strlen(p.bi) == 0){
		clientes[p.codigo].nif = p.nif;	
	}else{
		strcpy(clientes[p.codigo].bi, p.bi);
	}    
	clientes[p.codigo].telefone = p.telefone;
	//return true;
}

// F I M  A C T U A L I Z A Ç Ã O

// F U N Ç Ã O  L I S T A R  C L I E N T E S
int lista_de_clientes(){
	int n;
	if(strlen(clientes[0].nome) != 0){
		for(n=0; n<=clienteC-1; n++){
			printf("Codigo: %d\n", clientes[n].codigo);
			printf("Nome: %s", clientes[n].nome);
			if (strlen(clientes[n].bi) == 0){
				printf("NIF: %d\n", clientes[n].nif);
			}else{
				printf("BI: %s", clientes[n].bi);
			}
			printf("Telefone: %d\n", clientes[n].telefone);
			printf("------------------------------------------------------\n");	
		}
		return 1;	
	}else{
		return 0;
	}
}

// A B E R T U R A  D E  C O N T A S
int contasC = 0;
int abertura_de_contas(conta r){
	
	contas[contasC].codigo = contasC;
	contas[contasC].codigo_cliente = r.codigo_cliente;
	contas[contasC].numero_conta = 4000 + contasC;
	contas[contasC].estado = 1;
	contas[contasC].tipo_conta = r.tipo_conta;
	contas[contasC].saldo = 0.0;   
	
}

// F I M  A B E R T U R A  D E  C O N T A S

// D E P O S I T O  D E  V A L O R E S 

int deposito_de_valor(int codigo_client, int codigo_cont){
	float sal;
	printf("--------------------------------------------------\n");
	printf("Digite o valor a ser depositado (exemplo: 197.00): ");
	scanf("%f",&sal);
	fflush(stdin);
	printf("%.2f %d %d\n", sal, codigo_client, codigo_cont);
	printf("-----------------------------------------\n");
	printf("Deposito Efectuado com Sucesso\n");
	printf("-----------------------------------------\n");
	printf("Nome: %s",clientes[codigo_client].nome);
	printf("Conta: %d\n",contas[codigo_cont].numero_conta);
	printf("Saldo Inicial: %.2f\n",contas[codigo_cont].saldo);
	contas[codigo_cont].saldo = contas[codigo_cont].saldo + sal;
	printf("Saldo da Conta: %.2f\n",contas[codigo_cont].saldo);
	printf("-----------------------------------------\n");
	system("pause");	
}

// F I M  D E P O S I T O S

// L E V A N T A M E N T O  D E  V A L O R E S 

int levantamento_de_valor(int codigo_client, int codigo_cont){
	float sal;
	printf("--------------------------------------------------\n");
	printf("Digite o valor a ser Levantado (exemplo: 197.00): ");
	scanf("%f",&sal);
	fflush(stdin);
	printf("%.2f %d %d\n", sal, codigo_client, codigo_cont);
	printf("-----------------------------------------\n");
	printf("Levantamento Efectuado com Sucesso\n");
	printf("-----------------------------------------\n");
	printf("Nome: %s",clientes[codigo_client].nome);
	printf("Conta: %d\n",contas[codigo_cont].numero_conta);
	printf("Saldo Inicial: %.2f\n",contas[codigo_cont].saldo);
	contas[codigo_cont].saldo = contas[codigo_cont].saldo - sal;
	printf("Saldo da Conta: %.2f\n",contas[codigo_cont].saldo);
	printf("-----------------------------------------\n");
	system("pause");	
}

// F I M  L E V A N T A M E N T O

// T R A N S F E R E N C I A  D E  V A L O R E S 

int transferencia_de_valor(int codigo_client1, int codigo_cont1, int codigo_client2, int codigo_cont2){
	float sal;
	printf("--------------------------------------------------\n");
	printf("Digite o valor a ser transferido (exemplo: 197.00): ");
	scanf("%f",&sal);
	fflush(stdin);
	
	if(sal < contas[codigo_cont1].saldo){
		printf("-----------------------------------------\n");
		printf("Transferência Efectuada com Sucesso\n");
		printf("-----------------------------------------\n");
		printf("Nome do Cliente a Origem: %s",clientes[codigo_client1].nome);
		printf("Saldo Inicial: %.2f\n",contas[codigo_cont1].saldo);
		contas[codigo_cont1].saldo = contas[codigo_cont1].saldo - sal;
		printf("Saldo Actual: %.2f\n",contas[codigo_cont1].saldo);	
		printf("Nome do Cliente a Destino: %s",clientes[codigo_client2].nome);
		printf("Saldo Inicial: %.2f\n",contas[codigo_cont2].saldo);
	    contas[codigo_cont2].saldo = contas[codigo_cont2].saldo + sal;
		printf("Saldo Actual: %.2f\n",contas[codigo_cont2].saldo);
		printf("-----------------------------------------\n");
		system("pause");	
	}else{
		printf("-----------------------------------------\n");
		printf("Saldo da conta Origem Insuficiente\n");
		printf("Impissível realizar a transferência\n");
		printf("-----------------------------------------\n");
		system("pause");
	}
}

// F I M  T R A N S F E R E N C I A

// F U N C A O  B A C K U P

int backup(){
	int a;
	FILE *arq;
	arq = fopen("backup1.txt", "w");
		
	for(a=1;a<=clienteC-1;a++){
		fprintf(arq, "%d", clientes[clienteC].codigo);
		fprintf(arq, "%s", clientes[clienteC].nome);
		if(strlen(clientes[clienteC].bi) == 0){
		fprintf(arq, "%d", clientes[clienteC].nif);	
		}else{
		fprintf(arq, "%s", clientes[clienteC].bi);
		}    
		fprintf(arq, "%d", clientes[clienteC].telefone);
	}	

	fclose(arq);
}

// F I M  B A C K U P

// C O R P O  P R I N C I P A L  D O  P R O G R A M A
int main(){
	setlocale(LC_ALL, "Portuguese");
	// M E N U  P R I N C I P A L
	int op;
	do{
		system("cls");
		printf("---------------------------------------------------------------\n");
		printf("                M E N U  P R I N C I P A L                     \n");
		printf("---------------------------------------------------------------\n");
		printf(" 1 - CADASTRAR CLIENTE\n");
		printf(" 2 - LISTAR CLIENTES\n");
		printf(" 3 - ABERTURA DE CONTA\n");
		printf(" 4 - DEPOSITAR DINHEIRO\n");
		printf(" 5 - LEVANTAR DINHEIRO\n");
		printf(" 6 - TRANSFERIR DINHEIRO\n");
		printf(" 7 - CONSULTAR SALDO\n");
		printf(" 8 - ACTUALIZAR DADOS DO CLIENTE\n");
		printf(" 9 - TERMINAR\n");
		printf(" POR FAVOR ESCOLHA UMA OPCAO ACIMA: ");
		scanf("%d", &op);
		fflush(stdin);
		switch(op){
			case 1:
				system("cls");
				pessoa p;
				strcpy(p.bi, "");
				int t = 0;
				printf("--------------------------------------------------------\n");
				printf("   C A D A S T R O  D E   C L I E N T E S  B A I\n");
				printf("--------------------------------------------------------\n");
				printf("Escolha o tipo Cliente (0)- Particular// (1)- Empresa: ");
				scanf("%d", &t);
				fflush(stdin);
				if(t == 0){
					printf("--------------------------------------------------------\n");
					printf("          CADASTRO DE CLIENTE PARTICULAR\n");
					printf("--------------------------------------------------------\n");
					printf("Digite o nome do cliente: ");
					fgets(p.nome, 200, stdin);
					fflush(stdin);
					printf("Digite o número do BI: ");
					fgets(p.bi, 200, stdin);
					fflush(stdin);
					printf("Digite o número de telefone: ");
					scanf("%d", &p.telefone);
					fflush(stdin);
					if(cadastro_de_cliente(p)){
						printf("--------------------------------------------------------\n");
						printf("          CADASTRO EFECTUADO COM SUCESSO\n");
						printf("--------------------------------------------------------\n");	
					}				
					system("pause");
				}else if(t == 1){
					printf("--------------------------------------------------------\n");
					printf("          CADASTRO DE CLIENTE EMPRESA\n");
					printf("--------------------------------------------------------\n");
					printf("Digite o nome da Empresa: ");
					fgets(p.nome, 200, stdin);
					fflush(stdin);
					printf("Digite o NIF: ");
					scanf("%d", &p.nif);
					fflush(stdin);
					printf("Digite o número de telefone: ");
					scanf("%d", &p.telefone);
					fflush(stdin);
					if(cadastro_de_cliente(p)){
						printf("--------------------------------------------------------\n");
						printf("          CADASTRO EFECTUADO COM SUCESSO\n");
						printf("--------------------------------------------------------\n");	
					}				
					system("pause");
				}else{
					printf("OPÇÃO ESCOLHIDA INVÁLIDA, REPITA O PROCESSO");
				}
				break;
			case 2:
				system("cls");
				printf("------------------------------------------------------\n");
				printf("	LISTA DE CLIENTES CADASTRADOS              \n");
				printf("------------------------------------------------------\n");
				if(lista_de_clientes() == 1){
					printf("TOTAL REGISTOS: %d\n",clienteC);
					printf("------------------------------------------------------\n");
				}else{
					printf("    NAO HA REGISTO DE CLIENTES NO BANCO  \n");
					printf("------------------------------------------------------\n");
				}
				printf("               FIM DE REGISTOS                        \n");
				printf("------------------------------------------------------\n");
				system("pause");
				break;
			case 3:
				system("cls");
				int tipo_conta, codigo_cli;
				conta q;
				printf("--------------------------------------------------------\n");
				printf("   A B E R T U R A   D E   C L I E N T E S  B A I\n");
				printf("--------------------------------------------------------\n");
				printf("Escolha o tipo de Conta (0)- Particular// (1)- Empresa: ");
				scanf("%d", &tipo_conta);
				fflush(stdin);
				printf("Digite o codigo do Cliente: ");
				scanf("%d", &codigo_cli);
				fflush(stdin);
				if(strlen(clientes[codigo_cli].nome) != 0){
					printf("%d\n",codigo_cli);
					q.tipo_conta = tipo_conta;
					q.codigo_cliente = codigo_cli;
					abertura_de_contas(q);
					printf("--------------------------------\n");
					printf("Conta Aberta Com Sucesso\n");
					printf("--------------------------------\n");
					printf("   D A D O S  D A  C O N T A    \n");
					printf("\n");
					printf(" Nome do Titular: %s",clientes[q.codigo_cliente].nome);
					printf(" Numero da Conta: %d\n",contas[contasC].numero_conta);
					printf(" Saldo da Conta: %.2f\n",contas[contasC].saldo);
					if(contas[contasC].tipo_conta == 0){
						printf(" Tipo Conta: Particular\n");
					}else{
						printf(" Tipo Conta: Empresarial\n");
					}
					printf(" Estado: Activa\n");
					printf("---------------------------------\n");
					contasC = contasC + 1;              	
					system("pause");
				}else{
					printf("------------------------------------------------\n");
					printf("Impossivel Realizar Cadastro, Cliente Nao Existe\n");
					printf("------------------------------------------------\n");
					system("pause");
				}
				break;
			case 4:
				system("cls");
				int numero_conta, n, n_conta, codigo_cliente, codigo_conta;
				printf("-----------------------------------------------------\n");
				printf("   D E P O S I T O  D E   V A L O R E S  B A I     \n");
				printf("-----------------------------------------------------\n");
				printf("Digite o numero de conta que pretende depositar: ");
				scanf("%d", &numero_conta);
				fflush(stdin);
				for(n=0;n<=contasC-1;n++){
					if(contas[n].numero_conta == numero_conta){
						n_conta = numero_conta;
						codigo_cliente = contas[n].codigo_cliente;
						codigo_conta = contas[n].codigo;	
					}  	
				}
				if(numero_conta == n_conta){
					int y;
					printf("-----------------------------------------\n");
					printf("Confirme os dados do cliente inserido: \n");
					printf("-----------------------------------------\n");
					printf("Nome: %s",clientes[codigo_cliente].nome);
					printf("Conta: %d\n",contas[codigo_conta].numero_conta);
					printf("Saldo: %.2f\n",contas[codigo_conta].saldo);
					printf("-----------------------------------------\n");
					printf("Digite (0) para sim e (1) para não: ");
					scanf("%d",&y);
					fflush(stdin);
					switch(y){
						case 0:
							deposito_de_valor(codigo_cliente, codigo_conta);
							break;
						case 1:
							printf("--------------------------------------------------\n");
							printf("Operacao de Deposito Cancelada\n");
							system("pause");
							break;
						default:
							printf("OPÇÃO INVÁLIDA\n");
							system("pause");
							break;	
					}
				}else{
					printf("O Numero de Conta Inserido Não Existe\n");
					system("pause");	
				}	
				break;
			case 5:
				system("cls");
				int numer_conta, i, n_cont, codig_cliente, codig_conta;
				printf("-------------------------------------------------------\n");
				printf("   L E V A N T A M E N T O  D E   V A L O R E S  B A I     \n");
				printf("-------------------------------------------------------\n");
				printf("Digite o numero de conta por favor: ");
				scanf("%d", &numer_conta);
				fflush(stdin);
				for(i=0;i<=contasC-1;i++){
					if(contas[i].numero_conta == numer_conta){
						n_cont = numer_conta;
						codig_cliente = contas[i].codigo_cliente;
						codig_conta = contas[i].codigo;	
					}  	
				}
				if(numer_conta == n_cont){
					levantamento_de_valor(codig_cliente, codig_conta);
				}else{
					printf("O Numero de Conta Inserido Não Existe\n");
					system("pause");	
				}	
				break;
			case 6:
				system("cls");
				//CONTA 1
				int numer_conta1, i1, n_cont1, codig_cliente1, codig_conta1;
				printf("-----------------------------------------------------------\n");
				printf("   T R A N S F E R Ê N C I A  D E   V A L O R E S  B A I     \n");
				printf("-----------------------------------------------------------\n");
				printf("Digite o numero de conta origem: ");
				scanf("%d", &numer_conta1);
				fflush(stdin);
				for(i1=0;i1<=contasC-1;i1++){
					if(contas[i1].numero_conta == numer_conta1){
						n_cont1 = numer_conta1;
						codig_cliente1 = contas[i1].codigo_cliente;
						codig_conta1 = contas[i1].codigo;	
					}  	
				}
				//CONTA 2
				int numer_conta2, i2, n_cont2, codig_cliente2, codig_conta2;
				printf("-----------------------------------------------------------\n");
				printf("Digite o numero de conta destino: ");
				scanf("%d", &numer_conta2);
				fflush(stdin);
				for(i2=0;i2<=contasC-1;i2++){
					if(contas[i2].numero_conta == numer_conta2){
						n_cont2 = numer_conta2;
						codig_cliente2 = contas[i2].codigo_cliente;
						codig_conta2 = contas[i2].codigo;	
					}  	
				}
				if(numer_conta1 == n_cont1){
					if(numer_conta2 == n_cont2){
						transferencia_de_valor(codig_cliente1, codig_conta1,codig_cliente2, codig_conta2);
					}else{
						printf("O Numero de Conta Destino Não Existe\n");
						system("pause");	
					}
				}else{
					printf("O Numero de Conta Origem Não Existe\n");
					system("pause");	
				}	
				break;
			case 7:
				system("cls");
				int numer_conta3, i3, n_cont3, codig_cliente3, codig_conta3;
				printf("-----------------------------------------------------------\n");
				printf("       C O N S U L T A  D E  S A L D O  B A I       \n");
				printf("-----------------------------------------------------------\n");
				printf("Digite o numero de conta por favor: ");
				scanf("%d", &numer_conta3);
				fflush(stdin);
				for(i3=0;i3<=contasC-1;i3++){
					if(contas[i3].numero_conta == numer_conta3){
						n_cont3 = numer_conta3;
						codig_cliente3 = contas[i3].codigo_cliente;
						codig_conta3 = contas[i3].codigo;	
					}  	
				}
				if(n_cont3 == numer_conta3){
					printf("-----------------------------------------------------------\n");
					printf("Titular da Conta: %s",clientes[codig_cliente3].nome);
					printf("Numero da Conta: %d\n",contas[codig_conta3].numero_conta);
					printf("Saldo da Conta: %.2f\n",contas[codig_conta3].saldo);
					printf("-----------------------------------------------------------\n");
					system("pause");
				}else{
					printf("O Numero de Conta Inserido Não Existe\n");
					system("pause");		
				}
				break;
			case 8:
				system("cls");
				pessoa u;
				int codigo, codig_client, o;
				printf("------------------------------------------------------------\n");
				printf("   A C T U A L I Z A R  D A D O S  D O  C L I E N T E  B A I \n");
				printf("------------------------------------------------------------\n");
				printf("Por favor insira o codigo do cliente: ");
				scanf("%d",&codigo);
				fflush(stdin);
				for(o=0;o<=contasC-1;o++){
					if(clientes[o].codigo == codigo){
						codig_client = clientes[n].codigo;	
					}		
				}
				if(codig_client == codigo){
					int tipo_cont;
					u.codigo = codigo;
					printf("Escolha o tipo Cliente (0)- Particular// (1)- Empresa: ");
					scanf("%d",&tipo_cont); 
					fflush(stdin);
					switch(tipo_cont){
						case 0:
							printf("--------------------------------------------------------\n");
							printf("       ACTUALIZAÇÃO DOS DADOS - CLIENTE PARTICULAR\n     ");
							printf("--------------------------------------------------------\n");
							printf("Digite o nome do cliente: ");
							fgets(u.nome, 200, stdin);
							fflush(stdin);
							printf("Digite o número do BI: ");
							fgets(u.bi, 200, stdin);
							fflush(stdin);
							printf("Digite o número de telefone: ");
							scanf("%d", &u.telefone);
							fflush(stdin);
							if(actualizacao_dos_dados(u)){
								printf("--------------------------------------------------------\n");
								printf("          ACTUALIZAÇÃO EFECTUADA COM SUCESSO\n");
								printf("--------------------------------------------------------\n");	
							}				
							system("pause");
							break;
						case 1:
							printf("--------------------------------------------------------\n");
							printf("       ACTUALIZAÇÃO DOS DADOS - CLIENTE EMPRESA         \n");
							printf("--------------------------------------------------------\n");
							printf("Digite o nome da Empresa: ");
							fgets(u.nome, 200, stdin);
							fflush(stdin);
							printf("Digite o NIF: ");
							scanf("%d", &u.nif);
							fflush(stdin);
							printf("Digite o número de telefone: ");
							scanf("%d", &u.telefone);
							fflush(stdin);
							if(actualizacao_dos_dados(u)){
								printf("--------------------------------------------------------\n");
								printf("          ACTUALIZAÇÃO EFECTUADA COM SUCESSO\n");
								printf("--------------------------------------------------------\n");	
							}				
							system("pause");
							break;
						default:
							printf("OPÇÃO INSERIDA INVÁLIDA");
							system("pause");
							break;
					}	
				}else{
					printf("Codigo do Clinte Inserido Não Existe\n");
					system("pause");
				}
				break;
			case 9:
				backup();
				break;
			default:
				break;	
		}
	}while(op != 9);
	// F I M  M E N U  P R I N C I P A L
}
