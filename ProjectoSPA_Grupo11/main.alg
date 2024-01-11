//VARIAVEISS GLOBAIS
literal bn <- "\n"
inteiro n
procedimento bloquearTela()
	literal qt
	mostre "Prima Enter Para Continuar..."
	receba qt
	limpatela
fimprocedimento
//REGISTO PESSOA
registo pessoa
	inteiro codigo
	string nome
	inteiro nif
	string bi
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
	se strIsVazia(p.bi) entao
	    clientes[clienteC].nif <- p.nif
	senao
	    clientes[clienteC].bi <- p.bi
	fimse
	clientes[clienteC].telefone <- p.telefone
	clienteC <- clienteC + 1
	retorne verdadeiro
fimfuncao
//ACTUALIZAR DADOS DO CLIENTE
funcao logico actualizar_dados(pessoa j, inteiro codigo)
	clientes[codigo].nome <- j.nome
	se strIsVazia(j.bi) entao
	    clientes[codigo].nif <- j.nif
	senao
	    clientes[codigo].bi <- j.bi
	fimse
	clientes[codigo].telefone <- j.telefone
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
//LEVANTAR DINHEIRO
funcao logico levantar_dinheiro (real valor, inteiro cod_conta)
	contas[cod_conta].saldo <- contas[cod_conta].saldo - valor
	retorne verdadeiro
fimfuncao
funcao real consultar_saldo (inteiro codigo_conta)
	retorne contas[codigo_conta].saldo
fimfuncao
//COPIA DE SEGURANÇA
procedimento copia_seguranca(fficheiro f, fficheiro g)
	inteiro n
	para n de 0 ate clienteC - 1 aumentando 1
	    fescrever( f , strintparastr(clientes[n].codigo) + ";")
	    fescrever( f , clientes[n].nome + ";")
	    se strIsVazia(clientes[n].bi) entao
	    	fescrever( f , strintparastr(clientes[n].nif) + ";")
	    senao
	    	fescrever( f , clientes[n].bi + ";")
	    fimse
	    fescrever( f , strintparastr(clientes[n].telefone))
	    fNovaLinha(f) //Mudança de Linha
	fimpara
	para n de 0 ate contasC - 1 aumentando 1
	    fescrever( g , strintparastr(contas[n].codigo) + ";")
	    fescrever( g , strintparastr(contas[n].codigo_cliente) + ";")
	    fescrever( g , strintparastr(contas[n].numero_conta) + ";")
	    fescrever( g , strintparastr(contas[n].estado) + ";")
	    fescrever( g , strintparastr(contas[n].tipo_conta) + ";")
	    fescrever( g , strRealParaStr(contas[n].saldo) + ";")
	    fNovaLinha(g) //Mudança de Linha
    fimpara
fimprocedimento
//BACKUP DE FICHEIROS
procedimento recuperacao_dados(fficheiro f, fficheiro g)
	clienteC <- 0
    enquanto ftemlinha(f) faca 
        literal d[] <- strRepartir(fLerLinha(f), ";")
        inteiro r, i <- aTamanho(d, 0)
        	clientes[clienteC].codigo <- strValorInt(d[0])
        	clientes[clienteC].nome <- d[1]
        	se strTamanho(d[2]) > 6 entao
        		clientes[clienteC].bi <- d[2]
        	senao
        		clientes[clienteC].nif <- strValorInt(d[2]) 
        	fimse
        	clientes[clienteC].telefone <- strValorInt(d[3])
        clienteC <- clienteC + 1
    fimenquanto
	contasC <- 0
    enquanto ftemlinha(g) faca 
        literal d[] <- strRepartir(fLerLinha(g), ";")
        inteiro r, i <- aTamanho(d, 0)
        	contas[contasC].codigo <- strValorInt(d[0])
        	contas[contasC].codigo_cliente <- strValorInt(d[1])
        	contas[contasC].numero_conta <- strValorInt(d[2])
        	contas[contasC].estado <- strValorInt(d[3])
        	contas[contasC].tipo_conta <- strValorInt(d[4])
        	se strTamanho(d[5]) > 5 entao
        		literal sal, t[] <- strRepartir(d[5], ",")
        		inteiro k, tt <- aTamanho(t, 0)
        		para k de 0 ate tt - 1 aumentando 1
        			 sal <- sal + t[k]
        		fimpara
        		real sr <- strValorReal(sal)
        		contas[contasC].saldo <- sr
        	senao
        		contas[contasC].saldo <- strValorReal(d[5])
        	fimse
         contasC <- contasC + 1
    fimenquanto
fimprocedimento
inicio
//FICHEIRO clientes
	string caminho_backup <- fPastaUtilizador() + "\\Downloads\\ProjectoSPA_Grupo11\\files\\backup_isaf_cliente.txt"
	fficheiro f
    se nao  fExiste(caminho_backup) entao 
        se nao fcriar(caminho_backup) entao
        	limpatela
        	mostre "Nao ha banco de dados, seus registos nao serao armazenados",bn
        	tPause(2000)
        	limpatela
        fimse
    fimse
    //FICHEIRO contas
	string caminho_backup_conta <- fPastaUtilizador() + "\\Downloads\\ProjectoSPA_Grupo11\\files\\backup_isaf_conta.txt"
	fficheiro g
    se nao  fExiste(caminho_backup_conta) entao 
        se nao fcriar(caminho_backup_conta) entao
        	limpatela
        	mostre "Nao ha banco de dados, seus registos nao serao armazenados",bn
        	tPause(2000)
        	limpatela
        fimse
    fimse
// RESTAURAÇÃO DE DADOS
		logico APAGAR_CONTEUDO <- FALSO
    	fAbrir(f , caminho_backup , APAGAR_CONTEUDO)
		logico APAGAR_CONTEUDO_CONTA <- FALSO
    	fAbrir(g , caminho_backup_conta , APAGAR_CONTEUDO_CONTA)
		recuperacao_dados(f, g)
//FIM RESTAURAÇÃO
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
			receba c.nif
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
			receba c.bi
			mostre "Digite o telefone do Cliente:"
			receba c.telefone
			se cadastro_de_cliente(c) entao
				mostre "--------------------------------",bn
				mostre "Cadastro Efectuado Com Sucesso",bn
				mostre "--------------------------------",bn
				bloquearTela()
			fimse
			
		defeito:
			mostre "Opcao Invalida, por favor reinicie o cadastro",bn
			limpatela	
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
				se strIsVazia(clientes[n].bi) entao
				  	mostre "NIF: ",clientes[n].nif,bn
				senao
				    mostre "BI: ",clientes[n].bi,bn
				fimse
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
						mostre " Estado: Activa",bn
					senao
						mostre " Estado: Inativa",bn
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
		inteiro numero_conta, n, l, n_conta, codigo_cliente, codigo_conta
		mostre "-----------------------------------------------------",bn
		mostre "   D E P O S I T O  D E   V A L O R E S  B A I     ",bn
		mostre "-----------------------------------------------------",bn
		mostre "Digite o numero de conta que pretende depositar:"
		receba numero_conta
		l <- aTamanho(contas, 0)
		para n de 0 ate l-1 aumentando 1
			se contas[n].numero_conta = numero_conta entao
				n_conta <- numero_conta
				codigo_cliente <- contas[n].codigo_cliente
				codigo_conta <- contas[n].codigo
			fimse
		fimpara 
		se numero_conta = n_conta entao
			literal y
			real saldo
			mostre "-----------------------------------------",bn
			mostre "Confirme os dados do cliente inserido:",bn
			mostre "-----------------------------------------",bn
			mostre "Nome: ",clientes[codigo_cliente].nome,bn
			mostre "Conta: ",contas[codigo_conta].numero_conta,bn
			mostre "Saldo: ",contas[codigo_conta].saldo,bn
			mostre "-----------------------------------------",bn
			mostre "Digite (N) para não e (S) para sim: "
			receba y
			se y = "S" ou y = "s" entao
				mostre "--------------------------------------------------",bn
				mostre "Digite o valor a ser depositado (exemplo: 197.0): "
				receba saldo
				limpatela
				mostre "-----------------------------------------",bn
				mostre "Deposito Efectuado com Sucesso",bn
				mostre "-----------------------------------------",bn
				mostre "Nome: ",clientes[codigo_cliente].nome,bn
				mostre "Conta: ",contas[codigo_conta].numero_conta,bn
				mostre "Saldo Inicial: ",contas[codigo_conta].saldo,bn
				contas[codigo_conta].saldo <- contas[codigo_conta].saldo + saldo
				mostre "Saldo da Conta: ",contas[codigo_conta].saldo,bn
				mostre "-----------------------------------------",bn
				bloquearTela()
			senao
				mostre "--------------------------------------------------",bn
				mostre "Operacao de Deposito Cancelada",bn
				bloquearTela()
			fimse 
		senao
			mostre "O numero de conta Inserido não existe",bn
			bloquearTela()
		fimse	
	caso 5:
		limpatela
		inteiro numero_conta, n, l, n_conta, codigo_cliente, codigo_conta
		real saldo
		mostre "-----------------------------------------------------",bn
		mostre "   L E V A N T A M E N T O  D E  V A L O R E S  B A I     ",bn
		mostre "-----------------------------------------------------",bn
		mostre "Por favor insira o numero de conta: "
		receba numero_conta
		l <- aTamanho(contas, 0)
		para n de 0 ate l-1 aumentando 1
			se contas[n].numero_conta = numero_conta entao
				n_conta <- numero_conta
				codigo_cliente <- contas[n].codigo_cliente
				codigo_conta <- contas[n].codigo
			fimse
		fimpara
		se n_conta = numero_conta entao
			mostre "-----------------------------------------------------",bn
			mostre "Por favor digite a quantia a levantar (exemplo: 197.0): "
			receba saldo
			real saldoi <- contas[codigo_conta].saldo
			limpatela
			se saldo < saldoi entao
				se levantar_dinheiro(saldo, codigo_conta) entao
					mostre "-----------------------------------------",bn
					mostre "Levantamento Efectuado com Sucesso",bn
					mostre "-----------------------------------------",bn
					mostre "Nome: ",clientes[codigo_cliente].nome,bn
					mostre "Saldo Inicial: ",saldoi,bn
					mostre "Valor Levantado: ",saldo,bn 
					mostre "Saldo Actual da Conta: ",contas[codigo_conta].saldo,bn
					mostre "-----------------------------------------",bn
					bloquearTela()
				fimse
			senao
				mostre "Saldo da Conta Insuficiente!",bn
				bloquearTela()
			fimse
		senao
			mostre "O numero de conta Inserido não existe",bn
			bloquearTela()
		fimse
		
	caso 6:
		limpatela
		inteiro numero_conta, n, l, n_conta, codigo_cliente, codigo_conta
		mostre "----------------------------------------------------------",bn
		mostre "   C O N S U L T A  D E  S A L D O  D E  C O N T A  B A I     ",bn
		mostre "----------------------------------------------------------",bn
		mostre "Digite o numero de conta que pretende consultar: "
		receba numero_conta
		l <- aTamanho(contas, 0)
		para n de 0 ate l-1 aumentando 1
			se contas[n].numero_conta = numero_conta entao
				n_conta <- numero_conta
				codigo_cliente <- contas[n].codigo_cliente
				codigo_conta <- contas[n].codigo
			fimse
		fimpara
		se n_conta = numero_conta entao
			mostre "--------------------------------------------------------",bn
			mostre "Titular da Conta: ",clientes[codigo_cliente].nome,bn
			mostre "Numero da Conta: ",contas[codigo_conta].numero_conta,bn
			mostre "Saldo da Conta: ",consultar_saldo(codigo_conta),bn
			mostre "--------------------------------------------------------",bn
			bloquearTela()
		senao
			mostre "O numero de conta Inserido não existe",bn
			bloquearTela()
		fimse 
	caso 7:
		limpatela
		inteiro numero_conta1, numero_conta2, n, l, n_conta1, n_conta2, codigo_cliente1,codigo_cliente2, codigo_conta1, codigo_conta2
		conta q
		mostre "---------------------------------------------------------",bn
		mostre "   T R A N S F E R Ê N C I A  D E   V A L O R E S  B A I     ",bn
		mostre "---------------------------------------------------------",bn
		mostre "Digite o numero de conta origem:"
		receba numero_conta1
		l <- aTamanho(contas, 0)
		para n de 0 ate l-1 aumentando 1
			se contas[n].numero_conta = numero_conta1 entao
				n_conta1 <- numero_conta1
				codigo_cliente1 <- contas[n].codigo_cliente
				codigo_conta1 <- contas[n].codigo
			fimse
		fimpara
		mostre "----------------------------------------------------------",bn 
		mostre "Digite o numero de conta destino:"
		receba numero_conta2
		para n de 0 ate l-1 aumentando 1
			se contas[n].numero_conta = numero_conta2 entao
				n_conta2 <- numero_conta2
				codigo_cliente2 <- contas[n].codigo_cliente
				codigo_conta2 <- contas[n].codigo
			fimse
		fimpara 
		se numero_conta1 = n_conta1 entao
			se numero_conta2 = n_conta2 entao
				literal y
				real saldo1
				mostre "-----------------------------------------",bn
				mostre "Confirme os dados do cliente dos Clientes:",bn
				mostre "-----------------------------------------",bn
				mostre "Cliente a Enviar: ",clientes[codigo_cliente1].nome,bn
				mostre "Cliente a Receber: ",clientes[codigo_cliente2].nome,bn
				mostre "-----------------------------------------",bn
				mostre "Digite (N) para não e (S) para sim: "
				receba y
				se y = "S" ou y = "s" entao
					mostre "--------------------------------------------------",bn
					mostre "Digite o valor a ser transferido (exemplo: 197.0): "
					receba saldo1
					limpatela
					se saldo1 < contas[codigo_conta1].saldo entao
						mostre "-----------------------------------------",bn
						mostre "Transferência Efectuada com Sucesso",bn
						mostre "-----------------------------------------",bn
						mostre "Nome do Cliente a Enviar: ",clientes[codigo_cliente1].nome,bn
						mostre "Saldo Inicial: ",contas[codigo_conta1].saldo,bn
						contas[codigo_conta1].saldo <- contas[codigo_conta1].saldo - saldo1
						mostre "Saldo Actual: ",contas[codigo_conta1].saldo,bn	
						mostre "Nome do Cliente a Receber: ",clientes[codigo_cliente2].nome,bn
						mostre "Saldo Inicial: ",contas[codigo_conta2].saldo,bn
						contas[codigo_conta2].saldo <- contas[codigo_conta2].saldo + saldo1
						mostre "Saldo Actual: ",contas[codigo_conta2].saldo,bn
						mostre "-----------------------------------------",bn
						bloquearTela()
					senao
						mostre "-------------------------------------------",bn
						mostre "Saldo da conta Origem Insuficiente",bn
						mostre "Impissível realizar a transferência",bn
						mostre "-------------------------------------------",bn
						bloquearTela()
					fimse
				senao
					mostre "--------------------------------------------------",bn
					mostre "Operacao de transferência Cancelada!",bn
					bloquearTela()
				fimse
			senao
				mostre "O numero de conta destino não existe!",bn
				bloquearTela()
			fimse 
		senao
			mostre "O numero de conta origem não existe!",bn
			bloquearTela()
		fimse	
	caso 8:
		limpatela
		pessoa u
		inteiro codigo, codigo_cliente, n, l
		mostre "------------------------------------------------------------",bn
		mostre "   A C T U A L I Z A R  D A D O S  D O  C L I E N T E  B A I     ",bn
		mostre "------------------------------------------------------------",bn
		mostre "Por favor insira o codigo do cliente: "
		receba codigo
		l <- aTamanho(contas, 0)
		para n de 0 ate l-1 aumentando 1
			se clientes[n].codigo = codigo entao
				codigo_cliente <- clientes[n].codigo
			fimse
		fimpara
		se codigo_cliente = codigo entao
			inteiro tipo_conta
			mostre "Escolha o tipo Cliente (1)- Empresa// (2)- Particular:"
			receba tipo_conta 
			escolha tipo_conta
			caso 1:
				mostre "Digite o nome (à actualizar) do Cliente: "
				receba u.nome
				mostre "Digite o NIF (à actualizar) da empresa: "
				receba u.nif
				mostre "Digite o telefone (à actualizar) do Cliente: "
				receba u.telefone
			    se actualizar_dados(u, codigo_cliente) entao
					mostre "--------------------------------",bn
					mostre "Actualização Efectuada Com Sucesso",bn
					mostre "--------------------------------",bn
					bloquearTela()
				fimse
			caso 2:
				mostre "Digite o nome (à actualizar) do Cliente: "
				receba u.nome
				mostre "Digite o numero do BI (à actualizar) do Cliente: "
				receba u.bi
				mostre "Digite o telefone (à actualizar) do Cliente:"
				receba u.telefone
				se actualizar_dados(u, codigo_cliente) entao
					mostre "--------------------------------",bn
					mostre "Actualização Efectuada Com Sucesso",bn
					mostre "--------------------------------",bn
					bloquearTela()
				fimse
				
			defeito:
				mostre "Opcao Invalida, por favor reinicie a actualização",bn
				limpatela	
			fimescolha
		senao
			mostre "Codigo do Clinte Inserido Não Existe",bn
			bloquearTela()
		fimse
	caso 9:
		logico APAGAR_CONTEUDO1 <- VERDADEIRO
    	fAbrir(f , caminho_backup , APAGAR_CONTEUDO1)
		logico APAGAR_CONTEUDO_CONTA1 <- VERDADEIRO
    	fAbrir(g , caminho_backup_conta , APAGAR_CONTEUDO_CONTA1)
		copia_seguranca(f, g)
	defeito:
		limpatela
		mostre "----------------------------------------------------",bn
		mostre "OPÇÃO INSERIDA INVÁLIDA, ESCOLHA UMA OPÇÃO DE 1 À 9",bn
		mostre "----------------------------------------------------",bn
		bloquearTela()
	fimescolha
enquanto opcao <> 9
limpatela
mostre "---------------------------------------------------------------",bn
mostre "E S T E  S I S T E M A  F O I  D E S E N V O L V I D O  P O R:",bn
mostre "---------------------------------------------------------------",bn
mostre "Estudantes do 2º Ano de IGF do ISAF - GRUPO Nº 11:",bn
mostre "Bartolomeu Tomás",bn
mostre "Soriana Patrício",bn
mostre "Eurídio",bn
mostre "---------------------------------------------------------------",bn
mostre "OBRIGADO POR VISITAR O SISTEMA",bn
fimalgoritmo