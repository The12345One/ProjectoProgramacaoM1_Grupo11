//VARIAVEISS GLOBAIS
literal bn <- "\n"
inteiro n
procedimento bloquearTela()
	literal qt
	mostre "Prima Enter Para Continuar..."
	receba qt
	limpatela
fimprocedimento
//REGISTO DE NIF OU BI
registo nif_bi
	inteiro nif
	literal bi
fimregisto
//REGISTO PESSOA
registo pessoa
	inteiro codigo
	string nome
	nif_bi bi_nif
	inteiro telefone
fimregisto
pessoa clientes[100000]
//RESGISTO CONTA
registo conta
	inteiro codigo
	inteiro codigo_cliente
	inteiro numero_conta
	inteiro estado
	inteiro tipo_conta
	real saldo
fimregisto
conta contas[100000]
//CADASTRO DE CLIENTES
inteiro clienteC <- 0
funcao logico cadastro_de_cliente(pessoa p)
	clientes[clienteC].codigo <- clienteC
	clientes[clienteC].nome <- p.nome
	clientes[clienteC].bi_nif.nif <- p.bi_nif.nif
	clientes[clienteC].telefone <- p.telefone
	
	clienteC <- clienteC + 1
	retorne verdadeiro
fimfuncao
//ABERTURA DE CONTAS
inteiro contasC <- 0
funcao logico abertura_de_contas(conta p)
	contas[contasC].codigo <- contasC
	contas[contasC].codigo_cliente <- p.codigo_cliente
	contas[contasC].numero_conta <- 004000 + contasC
	contas[contasC].estado <- 1
	contas[contasC].tipo_conta <- p.tipo_conta
	contas[contasC].saldo <- 0.0
	retorne verdadeiro
fimfuncao
inicio
//FICHEIRO
	string caminho <- fPastaUtilizador() + "\\Downloads\\ProjectoSPA_Grupo11\\files\\bd.txt"
	fficheiro f
    se nao  fExiste(caminho) entao 
        se nao fcriar(caminho) entao
        	limpatela
        	mostre "Nao ha banco de dados, seus registos nao serao armazenados"
        	tPause(4000)
        	fim algoritmo
        fimse
    fimse
inteiro opcao
faca
	mostre "---------------------------------------------------------------",bn
	mostre "                M E N U  P R I N C I P A L                     ",bn
	mostre "---------------------------------------------------------------",bn
	mostre " 1 - CADASTRAR CLIENTE",bn
	mostre " 2 - LISTAR CLIENTES",bn
	mostre " 3 - ABERTURA DE CONTA",bn
	mostre " 4 - DEPOSITAR DINHEIRO",bn
	mostre " 5 - LEVANTAR DINHEIRO",bn
	mostre " 6 - CONSULTAR SALDO",bn
	mostre " 7 - TRANSFERIR DINHEIRO",bn
	mostre " 8 - ACTUALIZAR DADOS SO CLIENTE",bn
	mostre " 9 - TERMINAR",bn
	mostre " POR FAVOR ESCOLHA UMA OPCAO ACIMA: "
	receba opcao
	escolha opcao
	caso 1:
		limpatela
		inteiro tipo_conta
		pessoa c
		mostre "-----------------------------------------------------",bn
		mostre "   C A D A S T R O  D E   C L I E N T E S  B A I     ",bn
		mostre "-----------------------------------------------------",bn
		mostre "Escolha o tipo Cliente (1)- Empresa// (2)- Particular:"
		receba tipo_conta 
		escolha tipo_conta
		caso 1:
			mostre "Digite o nome do Cliente: "
			receba c.nome
			mostre "Digite o NIF da empresa: "
			receba c.bi_nif.nif
			mostre "Digite o telefone do Cliente: "
			receba c.telefone
		    se cadastro_de_cliente(c) entao
				mostre "--------------------------------",bn
				mostre "Cadastro Efectuado Com Sucesso",bn
				mostre "--------------------------------",bn
				bloquearTela()
			fimse
		caso 2:
			mostre "Digite o nome do Cliente: "
			receba c.nome
			mostre "Digite o numero do BI do Cliente: "
			receba c.bi_nif.bi
			mostre "Digite o telefone do Cliente:"
			receba c.telefone
			se cadastro_de_cliente(c) entao
				mostre "--------------------------------",bn
				mostre "Cadastro Efectuado Com Sucesso",bn
				mostre "--------------------------------",bn
				bloquearTela()
			fimse
			
		defeito:
			mostre "Opcao Invalida, por favor reinicie o cadastro"	
		fimescolha
	caso 2:
		limpatela
		mostre "------------------------------------------------------",bn
		mostre "	LISTA DE CLIENTES CADASTRADOS              ",bn
		mostre "------------------------------------------------------",bn
		se clientes[0].nome <> "" entao
			para n de 0 ate clienteC - 1
				mostre "Codigo: ",clientes[n].codigo,bn
				mostre "Nome: ",clientes[n].nome,bn
				mostre "Telefone: ",clientes[n].telefone,bn
				mostre "------------------------------------------------------",bn
			fimpara
		senao
			mostre "    NAO HA REGISTO DE CLIENTES NO BANCO  ",bn
		fimse
		mostre "               FIM DE REGISTOS                        ",bn
		mostre "------------------------------------------------------",bn
		bloquearTela()
	caso 3:
		limpatela
		inteiro tipo_conta
		conta q
		mostre "-----------------------------------------------------",bn
		mostre "   A B E R T U R A  D E   C O N T A S  B A I     ",bn
		mostre "-----------------------------------------------------",bn
		mostre "Escolha o tipo de Conta (1)- Empresa// (0)- Particular:"
		receba tipo_conta
			mostre "Digite o codigo do Cliente: "
			receba q.codigo_cliente
			se nao strIsVazia(clientes[q.codigo_cliente].nome) entao
				q.tipo_conta <- tipo_conta
				se abertura_de_contas(q) entao
					mostre "--------------------------------",bn
					mostre "Conta Aberta Com Sucesso",bn
					mostre "--------------------------------",bn
					mostre "   D A D O S  D A  C O N T A    ",bn
					mostre ""
					mostre " Nome do Titular: ",clientes[q.codigo_cliente].nome,bn
					mostre " Numero da Conta: ",contas[contasC].numero_conta,bn
					mostre " Saldo da Conta: ",contas[contasC].saldo,bn
					se contas[contasC].tipo_conta = 0 entao
						mostre " Tipo Conta: Particular",bn
					senao
						mostre " Tipo Conta: Empresarial",bn
					fimse
					se contas[contasC].estado = 1 entao
						mostre " Tipo Conta: Activa",bn
					senao
						mostre " Tipo Conta: Inativa",bn
					fimse
					mostre "---------------------------------",bn
					contasC <- contasC + 1               
					bloquearTela()	
				fimse
			senao
				mostre "------------------------------------------------",bn
				mostre "Impossivel Realizar Cadastro, Cliente Nao Existe",bn
				mostre "------------------------------------------------",bn
				bloquearTela()
			fimse
	caso 4:
		limpatela
		inteiro numero_conta
		conta q
		mostre "-----------------------------------------------------",bn
		mostre "   D E P O S I T O  D E   V A L O R E S  B A I     ",bn
		mostre "-----------------------------------------------------",bn
		mostre "Digite o numero de conta que pretende depositar:"
		receba numero_conta	
	caso 5:
		mostre ""
	caso 6:
		mostre ""
	caso 7:
		mostre ""
	caso 8:
		mostre ""
	caso 9:
		mostre ""
	defeito:
		mostre ""
	fimescolha
enquanto opcao <> 9

fimalgoritmo