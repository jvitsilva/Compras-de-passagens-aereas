import 'dart:io';

// classe relacionada à todas as informações do cliente
class Pessoa {
  String? nome, sobrenome, endereco;

  get getNome => this.nome;
  set setNome(String? nome) => this.nome = nome;

  get getSobrenome => this.sobrenome;
  set setSobrenome(String? sobrenome) => this.sobrenome = sobrenome;

  get getEndereco => this.endereco;
  set setEndereco(String? endereco) => this.endereco = endereco;

  // variavel cliente serve para controle de quem está cadastratrado e comprou as passagens
  // variavel passagemEscolhida serve para identificar qual passagem o cliente escolheu para comprar
  int? cliente, passagemEscolhida;

  get getCliente => this.cliente;
  set setCliente(int? cliente) => this.cliente = cliente;

  get getPassagemEscolhida => this.passagemEscolhida;
  set setPassagemEscolhida(int? passagemEscolhida) =>
      this.passagemEscolhida = passagemEscolhida;

  Pessoa(this.nome, this.sobrenome, this.endereco, this.cliente,
      this.passagemEscolhida);

  String toString() {
    return 'Nome: ${this.nome} ${this.sobrenome}, Endereço: ${this.endereco}\n';
  }
}

// classe em que armazeno as listas de objetos
class Operacoes {
  List<Pessoa> pessoas = [];
  void addPessoas(Pessoa adicionar) => pessoas.add(adicionar);

  List<Pagamento> pagamento = [];
  void addPagamento(Pagamento adicionar) => pagamento.add(adicionar);

  List<Passagens> passagens = [];
  void addPassagens(Passagens adicionar) => passagens.add(adicionar);
}

// classe relacionada a todas informações das passagens disponíveis
class Passagens {
  String? origem, destino, data;
  double? valor;

  Passagens(this.origem, this.destino, this.data, this.valor) {}

  get getValor => this.valor;
  set setValor(double? valor) => this.valor = valor;

  get getOrigem => this.origem;
  set setOrigem(String? origem) => this.origem = origem;

  get getDestino => this.destino;
  set setDestino(String? destino) => this.destino = destino;

  get getData => this.data;
  set setData(String? data) => this.data = data;

  String toString() {
    return 'Origem: ${this.origem}, Destino ${this.destino}, Data: ${this.data}, Valor: ${this.valor}';
  }
}

// classe dos dados bancarios do cliente
class Pagamento {
  String? banco;
  String? numCartao;
  double? saldo = 0.0;

  Pagamento(this.banco, this.numCartao, this.saldo) {}

  set setBanco(String? banco) => this.banco = banco;
  get getBanco => this.banco;

  get getNumCartao => this.numCartao;
  set setNumCartao(String? numCartao) => this.numCartao = numCartao;

  get getSaldo => this.saldo;
  set setSaldo(double? saldo) => this.saldo = saldo;
}

void main() {
  int controle = 0;
  Operacoes op = new Operacoes();
  Passagens pass1 = new Passagens("Belém", "Salvador", "27/11/2022", 450.0);
  op.addPassagens(pass1);
  Passagens pass2 =
      new Passagens("Belém", "Rio de Janeiro", "02/11/2022", 650.0);
  op.addPassagens(pass2);
  Passagens pass3 = new Passagens("Belém", "São Paulo", "05/11/2022", 650.0);
  op.addPassagens(pass3);
  Passagens pass4 = new Passagens("Belém", "Fortaleza", "10/10/2022", 350.0);
  op.addPassagens(pass4);
  Passagens pass5 = new Passagens("Belém", "Curitiba", "01/11/2022", 700.0);
  op.addPassagens(pass5);
  Passagens pass6 = new Passagens("Belém", "Porto Alegre", "15/12/2022", 850.0);
  op.addPassagens(pass6);

  print("Bem vindo á transportadora de corpo Guanabara!");

  while (controle != 4) {
    print("########## MENU ##########");
    print("1 - Cadastrar informações");
    print("2 - Agendar passagens");
    print("3 - Informações gerais");
    print("4 - Sair");
    var escolha = int.parse(stdin.readLineSync()!);

    switch (escolha) {
      case 1:
        print("Digite seu nome: ");
        var nomeInput = stdin.readLineSync()!;
        print("Digite seu sobrenome: ");
        var sobrenomeInput = stdin.readLineSync()!;
        print("Digite seu endereço: ");
        var enderecoInput = stdin.readLineSync()!;

        Pessoa info =
            new Pessoa(nomeInput, sobrenomeInput, enderecoInput, 0, 0);
        op.addPessoas(info);

        print("Digite o nome do seu banco: ");
        var bancoInput = stdin.readLineSync()!;
        print("Digite o número do seu cartão: ");
        var numCartaoInput = stdin.readLineSync()!;
        print("Digite seu saldo no banco: ");
        var saldoInput = double.parse(stdin.readLineSync()!);

        Pagamento pag = new Pagamento(bancoInput, numCartaoInput, saldoInput);
        op.addPagamento(pag);
        break;

      case 2:
        print("Primeiro, indique o número do seu cadastro:");

        for (var i = 0; i < op.pessoas.length; i++) {
          print("${i + 1} - ${op.pessoas[i]}");
        }
        var numCadastro = int.parse(stdin.readLineSync()!);

        print("Agora digite o número da compra desejada:");
        for (var i = 0; i < op.passagens.length; i++) {
          print("${i + 1} - ${op.passagens[i]}");
        }
        var numPass = int.parse(stdin.readLineSync()!);

        // Esse switch serve para fazer as devidas operações depois de identificar a pessoa e qual passagem ele quer comprar
        switch (numPass) {
          case 1:
            print("Você escolheu ${op.passagens[0]}");
            // se a pessoa tem dinheiro suficiente para comprar
            if (op.pagamento[numCadastro - 1].getSaldo >= 450) {
              var controle = op.pagamento[numCadastro - 1].getSaldo;
              controle -= 450;
              op.pagamento[numCadastro - 1].setSaldo = controle;
              op.pessoas[numCadastro - 1].setCliente = 1;
              op.pessoas[numCadastro - 1].setPassagemEscolhida = 0;

              print("Passagem comprada com sucesso!");
            }
            //Se não possui dinehiro suficiente
            else
              print("Você não tem dinheiro para comprar esta passagem!");
            print("Deseja depositar algum valor? s/n");
            var resp = stdin.readLineSync()!;

            if (resp == 's' || resp == 'S') {
              var saldoInicial = op.pagamento[numCadastro - 1].getSaldo;
              print("Seu saldo: ${op.pagamento[numCadastro - 1].getSaldo}");
              print("Quanto deseja depositar?");
              var deposito = double.parse(stdin.readLineSync()!);
              saldoInicial += deposito;
              op.pagamento[numCadastro - 1].setSaldo = saldoInicial;

              var controle = op.pagamento[numCadastro - 1].getSaldo;
              controle -= 450;
              op.pagamento[numCadastro - 1].setSaldo = controle;
              op.pessoas[numCadastro - 1].setCliente = 1;
              op.pessoas[numCadastro - 1].setPassagemEscolhida = 0;

              print("Passagem comprada com sucesso!");
            }

            break;

          case 2:
            print("Você escolheu ${op.passagens[1]}");
            // se a pessoa tem dinheiro suficiente para comprar
            if (op.pagamento[numCadastro - 1].getSaldo >= 650) {
              var controle = op.pagamento[numCadastro - 1].getSaldo;
              controle -= 650;
              op.pagamento[numCadastro - 1].setSaldo = controle;
              op.pessoas[numCadastro - 1].setCliente = 1;
              op.pessoas[numCadastro - 1].setPassagemEscolhida = 1;

              print("Passagem comprada com sucesso!");
            }
            //Se não possui dinehiro suficiente
            else
              print("Você não tem dinheiro para comprar esta passagem!");
            print("Deseja depositar algum valor? s/n");
            var resp = stdin.readLineSync()!;

            if (resp == 's' || resp == 'S') {
              var saldoInicial = op.pagamento[numCadastro - 1].getSaldo;
              print("Seu saldo: ${op.pagamento[numCadastro - 1].getSaldo}");
              print("Quanto deseja depositar?");
              var deposito = double.parse(stdin.readLineSync()!);
              saldoInicial += deposito;
              op.pagamento[numCadastro - 1].setSaldo = saldoInicial;
              var controle = op.pagamento[numCadastro - 1].getSaldo;
              controle -= 650;
              op.pagamento[numCadastro - 1].setSaldo = controle;
              op.pessoas[numCadastro - 1].setCliente = 1;
              op.pessoas[numCadastro - 1].setPassagemEscolhida = 1;
            }
            break;

          case 3:
            print("Você escolheu ${op.passagens[2]}");
            // se a pessoa tem dinheiro suficiente para comprar
            if (op.pagamento[numCadastro - 1].getSaldo >= 650) {
              var controle = op.pagamento[numCadastro - 1].getSaldo;
              controle -= 650;
              op.pagamento[numCadastro - 1].setSaldo = controle;
              op.pessoas[numCadastro - 1].setCliente = 1;
              op.pessoas[numCadastro - 1].setPassagemEscolhida = 2;

              print("Passagem comprada com sucesso!");
            }
            //Se não possui dinehiro suficiente
            else
              print("Você não tem dinheiro para comprar esta passagem!");
            print("Deseja depositar algum valor? s/n");
            var resp = stdin.readLineSync()!;

            if (resp == 's' || resp == 'S') {
              var saldoInicial = op.pagamento[numCadastro - 1].getSaldo;
              print("Seu saldo: ${op.pagamento[numCadastro - 1].getSaldo}");
              print("Quanto deseja depositar?");
              var deposito = double.parse(stdin.readLineSync()!);
              saldoInicial += deposito;
              op.pagamento[numCadastro - 1].setSaldo = saldoInicial;
              var controle = op.pagamento[numCadastro - 1].getSaldo;
              controle -= 650;
              op.pagamento[numCadastro - 1].setSaldo = controle;
              op.pessoas[numCadastro - 1].setCliente = 1;
              op.pessoas[numCadastro - 1].setPassagemEscolhida = 1;
            }
            break;

          case 4:
            print("Você escolheu ${op.passagens[3]}");
            // se a pessoa tem dinheiro suficiente para comprar
            if (op.pagamento[numCadastro - 1].getSaldo >= 350) {
              var controle = op.pagamento[numCadastro - 1].getSaldo;
              controle -= 350;
              op.pagamento[numCadastro - 1].setSaldo = controle;
              op.pessoas[numCadastro - 1].setCliente = 1;
              op.pessoas[numCadastro - 1].setPassagemEscolhida = 3;

              print("Passagem comprada com sucesso!");
            }
            //Se não possui dinehiro suficiente
            else {
              print("Você não tem dinheiro para comprar esta passagem!");
              print("Deseja depositar algum valor? s/n");
              var resp = stdin.readLineSync()!;

              if (resp == 's' || resp == 'S') {
                var saldoInicial = op.pagamento[numCadastro - 1].getSaldo;
                print("Seu saldo: ${op.pagamento[numCadastro - 1].getSaldo}");
                print("Quanto deseja depositar?");
                var deposito = double.parse(stdin.readLineSync()!);
                saldoInicial += deposito;
                op.pagamento[numCadastro - 1].setSaldo = saldoInicial;
                var controle = op.pagamento[numCadastro - 1].getSaldo;
                controle -= 350;
                op.pagamento[numCadastro - 1].setSaldo = controle;
                op.pessoas[numCadastro - 1].setCliente = 1;
                op.pessoas[numCadastro - 1].setPassagemEscolhida = 3;

                print("Passagem comprada com sucesso!");
              }
            }
            break;

          case 5:
            print("Você escolheu ${op.passagens[4]}");
            // se a pessoa tem dinheiro suficiente para comprar
            if (op.pagamento[numCadastro - 1].getSaldo >= 700) {
              var controle = op.pagamento[numCadastro - 1].getSaldo;
              controle -= 700;
              op.pagamento[numCadastro - 1].setSaldo = controle;
              op.pessoas[numCadastro - 1].setCliente = 1;
              op.pessoas[numCadastro - 1].setPassagemEscolhida = 4;

              print("Passagem comprada com sucesso!");
            }
            //Se não possui dinehiro suficiente
            else
              print("Você não tem dinheiro para comprar esta passagem!");
            print("Deseja depositar algum valor? s/n");
            var resp = stdin.readLineSync()!;

            if (resp == 's' || resp == 'S') {
              var saldoInicial = op.pagamento[numCadastro - 1].getSaldo;
              print("Seu saldo: ${op.pagamento[numCadastro - 1].getSaldo}");
              print("Quanto deseja depositar?");
              var deposito = double.parse(stdin.readLineSync()!);
              saldoInicial += deposito;
              op.pagamento[numCadastro - 1].setSaldo = saldoInicial;
              var controle = op.pagamento[numCadastro - 1].getSaldo;
              controle -= 700;
              op.pagamento[numCadastro - 1].setSaldo = controle;
              op.pessoas[numCadastro - 1].setCliente = 1;
              op.pessoas[numCadastro - 1].setPassagemEscolhida = 4;

              print("Passagem comprada com sucesso!");
            }
            break;

          case 6:
            print("Você escolheu ${op.passagens[5]}");
            // se a pessoa tem dinheiro suficiente para comprar
            if (op.pagamento[numCadastro - 1].getSaldo >= 850) {
              var controle = op.pagamento[numCadastro - 1].getSaldo;
              controle -= 850;
              op.pagamento[numCadastro - 1].setSaldo = controle;
              op.pessoas[numCadastro - 1].setCliente = 1;
              op.pessoas[numCadastro - 1].setPassagemEscolhida = 5;

              print("Passagem comprada com sucesso!");
            }
            //Se não possui dinehiro suficiente
            else
              print("Você não tem dinheiro para comprar esta passagem!");
            print("Deseja depositar algum valor? s/n");
            var resp = stdin.readLineSync()!;

            if (resp == 's' || resp == 'S') {
              var saldoInicial = op.pagamento[numCadastro - 1].getSaldo;
              print("Seu saldo: ${op.pagamento[numCadastro - 1].getSaldo}");
              print("Quanto deseja depositar?");
              var deposito = double.parse(stdin.readLineSync()!);
              saldoInicial += deposito;
              op.pagamento[numCadastro - 1].setSaldo = saldoInicial;
              var controle = op.pagamento[numCadastro - 1].getSaldo;
              controle -= 850;
              op.pagamento[numCadastro - 1].setSaldo = controle;
              op.pessoas[numCadastro - 1].setCliente = 1;
              op.pessoas[numCadastro - 1].setPassagemEscolhida = 5;

              print("Passagem comprada com sucesso!");
            }
            break;
        }

        break;

      case 3:
        // listar todos os clientes
        print("### Clientes ###");
        for (var i = 0; i < op.pessoas.length; i++) {
          if (op.pessoas[i].getCliente == 1) {
            print(
                "\nNome: ${op.pessoas[i].getNome} ${op.pessoas[i].getSobrenome}, Endereço: ${op.pessoas[i].getEndereco}, Saldo: ${op.pagamento[i].getSaldo}");
            print(
                "Passagem: ${op.passagens[op.pessoas[i].getPassagemEscolhida].getOrigem} para ${op.passagens[op.pessoas[i].getPassagemEscolhida].getDestino}, Dia ${op.passagens[op.pessoas[i].getPassagemEscolhida].getData}, Valor: ${op.passagens[op.pessoas[i].getPassagemEscolhida].getValor}\n");
          }
        }

        break;

      case 4:
        // sair do menu
        controle = 4;
        break;

      default:
        print("Comando inválido");
    }
  }
}
