#### 18/12/2023

Curso de Testes de unidade e Widget com Mocks: boas práticas no Flutter

@01-Criando primeiros testes

@@01
Introdução

Boas vindas! Este é o curso Testes de Unidade e Widget com mocks: boas práticas no Flutter com o instrutor Alex Felipe.
É necessário ter conhecimento sobre todo o conteúdo apresentado até o segundo curso de web API em Flutter, pois reutilizaremos o mesmo projeto feito durantes essas aulas, agora focando na garantia de funcionamento de alguns comportamentos do aplicativo a partir de testes, considerando o ambiente do Flutter.

Exploraremos a documentação e entenderemos as diversas categorias de testes vindas dos Teste de Unidade, Teste de widget e Teste de Integração, analisando quais deles serão aplicados ao longo do curso, em especial os dois primeiros.

Aprenderemos como fazer todos os tipos de teste dessas categorias, considerando alguma cobertura de nosso aplicativo; garantiremos que o Dashboard seja apresentado ao acessá-lo, que o botão "Transfer" seja clicável e apresente a tela de lista de contatos, e inclusive nos certificaremos dos fluxos, como no caso de criação de um novo contato pelo preenchimento do formulário.

Descobriremos a melhor forma de criar testes para atestar o bom funcionamento destes comportamentos, e nos depararemos com diversos desafios e surpresas ao longo do caminho, pois alguns problemas não foram percebiodos no teste visual.

Nosso objetivo é identificar exatamente como o Flutter nos oferece ferramentas para gerar essas garantias. Além disso, veremos tecnicamente como utilizar objetos simulados ou mock objects a partir do pacote Mockito. Conheceremos também um novo widget chamado InheritedWidget para podermos usar a injeção de dependências e assim consiguirmos fazer os mocks, veremos alguns problemas comuns na implementação destes tipos de testes envolvendo fluxo, e entenderemos como simular estas integrações.

Este é um curso no qual conseguiremos garantir que os comportamentos principais estejam funcionando como queremos conforme os parâmetros e ações esperados.

Então vamos lá!

@@02
Orientações iniciais e organização do curso

Pré-requisito
Neste curso, assumimos que você conheça todo conteúdo apresentado no Comunicação HTTP: Flutter com web API.

Caso você não tenha feito o curso, mas acredita que possa começar a partir daqui, fique à vontade para continuar. Porém, se tiver algum conteúdo que não foi explicado com tanta atenção, muito provavelmente ele já foi explicado em um curso anterior. De qualquer forma, você pode entrar em contato com a gente por meio do fórum.

Como o curso está organizado
Cada aula contém vídeos e exercícios, sendo que cada vídeo vai ter, pelo menos, um exercício.

Este é um curso classificado como intermediário, isso significa que alguns exercícios não serão tão passo a passo como um curso básico. Mas não se preocupe, pois todas as orientações necessárias serão apresentadas.

Sinta-se livre para primeiro assistir a aula, prestar atenção no conteúdo, e depois executar o que foi feito em aula apenas no exercício.

Se preferir executar as etapas junto com o instrutor, fique à vontade, porém, saiba que daremos todo auxílio necessário nos exercícios. Recomendamos fortemente primeiro assistir a aula com atenção para depois praticar :)

https://cursos.alura.com.br/course/flutter-comunicacao-http

@@03
Preparando o ambiente - Projeto inicial

Neste curso utilizamos o mesmo projeto desenvolvido no curso listado como o pré requisito. Portanto, se tiver o mesmo projeto, prossiga para a.
Caso contrário, você pode baixar o projeto e abri-lo na IDE

https://github.com/alura-cursos/flutter-tests/archive/initial-project.zip

@@04
Testes no Flutter

Considerando que nosso objetivo é testar o aplicativo, o primeiro passo é a apresentação do ambiente de testes utilizando Flutter. Acessando a documentação, temos a parte de Testing & Debugging que possui a opção Testing.
Esta página é dedicada a falar sobre testes no ambiente do Flutter, e o texto introduz que é a partir destes recursos que garantiremos a consistência de um aplicativo. Em seguida, apresenta três categorias possíveis e comuns; o primeiro é o Unit Test ou Teste de Unidade, o qual foca na regra de negócio, seja uma função, classe ou métodos. Como exemplo, poderíamos tornar um teste responsável por validar uma transferência, permitindo sua criação somente quando possuir o valor acima de zero.

Além do Teste de Unidade, temos o Widget Test ou Teste de Widget, mais relacionado ao UI e aos componentes criados. Basicamente, seu objetivo é nos tornar capazes de testar um único widget, por exemplo para saber se ele recebe o valor esperado ou se apresenta o conteúdo correto.

Por fim, temos o Integration Test ou Teste de Integração, que difere dos demais por realizar testes mais longos nos quais conseguimos validar boa parte do aplicativo, seja um pequeno fluxo ou fluxo inteiro, conhecido como end-to-end ou ponta-a-ponta.

Essas são as três grandes categorias distintas de testes presentes no Flutter. Na mesma página da documentação, temos um texto explicando que um aplicativo bem testado possui muitos testes de Unidade e Widget, considerando a cobertura de nosso código. Caso queiramos adicionar o de Integração, é recomendado aplicá-lo somente nas partes mais importantes e sensíveis do projeto para garantir o funcionamento de todo o fluxo.

Mais adiante no texto, há uma tabela indicando os trade-offs com os níveis de confiança, custo de manutenção, dependências e velocidade de execução de cada categoria. O de Unidade possui baixa confiança e manutenção, enquanto as dependências são poucas devido ao isolamento do código de teste em uma classe ou função específica, sendo executado com rapidez.

No caso do Teste de Widget, os dois primeiros critérios são maiores porque estão relacionados, já que widgets possuem maior integração, levando a um maior número de dependências mas mantendo a velocidade da execução. Isso porque esse teste utiliza a AVM do Dart, dispensando a necessidade de um emulador. Portanto, é um feedkback bastante positivo, mesmo em relação a outros ambientes.

Por fim, o de Teste de Integração é bem mais confiável, mais custoso de manter e com maior quantidade de dependências. Entretanto, sua execução é lenta.

Tabela de Trade-offs para cada tipo de teste

Considerando estes trade-offs, temos a sugestão de aplicar mais os dois primeiros testes, fazendo com que o de Integração exista, mas seja menor, justamente por sua lentidão e complexidade.

Com essas informações, focaremos em conhecer melhor o ambiente de Flutter, fazer alguns Testes de Unidade e então prestar maior atenção ao Teste de Widget, afinal este é o meio termo entre os os outros, possuindo a capacidade de realizar a validação tanto de um único widget quanto de um fluxo. Há peculiaridades a serem observadas para fazer com que ele seja rápido o suficiente para nos fornecer o maior feedback.

A seguir, começaremos a entender melhor como este ambiente de testes funcionará em nosso projeto.

@@05
Para saber mais - Conteúdos de testes automatizados

Durante a introdução do ambiente de testes no Flutter, vimos que existem 3 categorias principais de testes. Durante o curso, focaremos em testes de Widgets.
Portanto, se tiver interesse em conhecer mais sobre testes de unidade ou de integração, confira as seguintes páginas:

Cookbook de teste de unidade no Flutter;
Package test do Dart;
Cookbook de teste de integração no Flutter com flutter_driver.

https://flutter.dev/docs/cookbook/testing/unit/introduction

https://pub.dev/packages/test

https://flutter.dev/docs/cookbook/testing/integration/introduction

@@06
Criando testes de unidade

Feita a introdução sobre o ambiente de testes em Flutter, conheceremos a configuração de testes que será realizada em nosso projeto.
Para isso, acessaremos o projeto raiz bytebank, dentro da pasta "test", abriremos o arquivo widget_test.dart, que possui um código preparado para o projeto inicial no momento de sua criação, incluindo o contador de exemplo que mostra como funciona a implementação de um aplicativo em Flutter. Também encontraremos um teste mostrando os passos a serem considerados para um Teste de Widget.

 void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(BytebankApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}COPIAR CÓDIGO
Se o executarmos clicando no ícone play da primeira linha de main(),a execução falhará, pois o sistema tentará verificar componentes que antes estavam presentes no projeto e agora não estão mais. Sendo assim, o teste só funcionaria se criássemos o projeto novamente, visto que o modificamos bastante.

Cientes disso, apagaremos este arquivo, já que faremos cada etapa da configuração. O diretório "test" serve para criarmos os arquivos de teste em .dart, que não possui grandes diferenças em relação aos demais, tendo inclusive o método main() que faz a execução. Deletado o arquivo, começaremos a criação do nosso próprio código de teste em um novo documento chamado transaction_teste.dart.

Neste primeiro momento, criamos um Teste de Unidade para nossa classe de transferência adicionando o método main() seguido da função test(), que pede as propriedadesdescription e body. Essa última função é disponibilizada automaticamente na criação do projeto com a importação da dependência flutter_test em pubspec.yaml, dependência essa que serve tanto para Testes de Widget quanto Testes de Unidade. Entretanto, Testes de Integração necessitam de outro pacote.

Agora precisamos definir a ação a ser executada no teste, o que é feito na propriedade description. Por exemplo, queremos que nosso teste retorne o valor de uma transferência quando ela é criada. Sendo assim, vamos inserir uma string com a mensagem "Should return the value when create a transaction".

Este teste é bastante simples, pois nosso objetivo não é discutir o que é importante testar ou não, considerando as regras de Test Driven Development (ou TDD), mas sim entender como criar nosso Teste de Unidade.

No corpo de test(), implementaremos uma função que passa os valores esperados para uma instância deTransaction() (cujo modelo deverá ser importado). Nesse caso, passaremos null como ID e contato, já que nosso único objetivo é verificar o valor, que passaremos como 200.

Devolvemos a transferência criada para uma variável e incluiremos a função expect(), que nos permite enviar o que temos atualmente - a transferência que acabamos de criar - e o que esperamos receber. Sendo assim, indicaremos o recebimento de transaction.value, cujo valor esperamos que seja 200.

void main(){
  test('Should return the value when create a transaction', () {
    final transaction = Transaction(null, 200, null);
    expect(transaction.value, 200);
  });
}COPIAR CÓDIGO
Para executarmos o teste, clicaremos novamente no botão de "Play" ou usaremos o atalho "Shift + F10". Nosso primeiro teste passará normalmente, mas é importante verificarmos se ele está realmente funcionando. Para isso, alteraremos o valor de 200 para 300 em expect() e rodaremos o código novamente.

Dessa vez, teremos um retorno de falha indicando o arquivo onde ocorreu o erro, o valor esperado e o valor recebido.

package:test_api                                   expect
package:flutter_test/src/widget_tester.dart 234:3  expect
test\transaction_test.dart 7:5                     main.<fn>

Expected: <300>
  Actual: <200.0>COPIAR CÓDIGO
Assim, conseguimos criar nosso primeiro Teste de Unidade. Criaremos então um segundo teste, dessa vez validando a transferência para que esta não receba valores menores ou iguais a zero. Simulando um TDD, adicionaremos outra chamada de test() descrita como "Should show error when create transaction with value less than zero".

A descrição do teste é livre, mas disponibilizaremos nos exercícios alguns padrões que podem ser considerados para nomear testes. O padrão utilizado aqui indica o que deve acontecer, nesse caso um erro, e a situação em que isso deve acontecer.

Após a descrição, adicionaremos no corpo um expect() indicando a criação de uma Transaction() recebendo null, 0, null. No lugar de matcher, verificaremos os erros com um throwsAssertionError.

void main(){
  test('Should return the value when create a transaction', () {
    final transaction = Transaction(null, 200, null);
    expect(transaction.value, 200);
  });
  test('Should show error when create transaction with value less than zero', () {
    expect((Transaction(null, 0, null)), throwsAssertionError);
  });
}COPIAR CÓDIGO
Ao rodarmos o teste, receberemos no retorno uma mensagem informando que, apesar de esperarmos um erro, a transferência foi criada sem problemas. Dado que agora temos um teste validando esse comportamento, alteraremos o modelo Transaction de modo que ele consiga enviar esse throwsAssertionError na situação descrita.

class Transaction {
  final double value;
  final Contact contact;
  final String id;

  Transaction(
      this.id,
      this.value,
      this.contact,
      ) : assert(value > 0);COPIAR CÓDIGO
Se executarmos com o "Shift + F10", o sistema ainda nos retornará um problema, pois quando ocorre algum problema na validação, o Flutter deixa de fazer a validação. Para corrigirmos isso, faremos uma conversão no código do segundo teste para que a execução no construtor seja feita dentro de uma função, o que é feito por meio da implementação de um callback, ou seja, fazendo que com que uma função obtenha a criação da transferência.

void main(){
  test('Should return the value when create a transaction', () {
    final transaction = Transaction(null, 200, null);
    expect(transaction.value, 200);
  });
  test('Should show error when create transaction with value less than zero', () {
    expect(() => Transaction(null, 0, null), throwsAssertionError);
  });
}COPIAR CÓDIGO
Ao executarmos novamente, nosso teste passará com sucesso. Conforme criamos uma bateria de testes, deixa de fazer sentido nós os executarmos individualmente. Colocando o cursor sobre o método main() e usando o atalho "Ctrl + Shift + F10" podemos executar todos os testes de uma só vez. Se clicarmos no botão de check da janela de execução, os testes que foram realizados serão mostrados em uma lista.

Se forçarmos um erro inserindo outro valor em expect(), o sistema indicará a execução da bateria de testes e o ponto que falhou. Assim, poderemos corrigir o código diretamente e executar o teste outra vez.

A confiança desse tipo de teste não é a melhor, afinal testamos apenas uma parte do projeto. Porém, o custo de manutenção é baixo e não temos tantas dependências para testar em nosso negócio, tornando o processo bastante rápido.

@@07
Implementando os testes de unidade

Implemente testes de unidade para o modelo de transferência, para isso crie o arquivo de teste no diretório test e escreva a função main(). Em seguida, chame a função test do pacote flutter_test e escreva os seguintes testes:
Avaliar se ao criar a transferência com um valor específico o mesmo é retornado;
Avaliar se ao criar uma transferência com valor menor que zero é lançado um AssertionError.
Caso já conheça técnicas de criação de testes, como é caso do TDD, fique à vontade para aplicá-las.

Para nomear as testes, você pode ser o mesmo padrão em vídeo ou um que preferir. Se tiver interesse em conhecer outras possibilidades, confira esse artigo.

Ao rodar os testes, confira se ambos passam, caso contrário ajuste o código até que o teste passe.

Lembre-se que testes que avaliam o lançamento de exception/error via construtor precisam ser envolvidos em uma função.

https://tdd.caelum.com.br/

https://dzone.com/articles/7-popular-unit-test-naming

O teste deve passar sem apresentar problemas. Você pode conferir o código desta atividade a partir deste commit.

https://github.com/alura-cursos/flutter-tests/commit/30953f915cee0c3881d6b11efa02fb37ab91d05d

@@08
Primeiros testes de widgets

Transcrição

Com os primeiros Testes de Unidade implementados, podemos partir para os Testes de Widgets que são o foco deste curso. Como primeiro passo abordaremos atela inicial do aplicativo, que é o Dashboard, por meio de testes simples que verificarão a existência de alguns componentes, como a imagem principal e a primeira funcionalidade (o botão "Transfer").
Precisaremos de um arquivo próprio destinado a este tipo de teste, da mesma maneira feita anteriormente para a transferência. Portanto, criaremos um arquivo dashboard_widget_test.dart no diretório "test".

Sempre que geramos um arquivo de teste exclusivo para algum componente do aplicativo, começamos com o método main(). Em seguida, usaremos a função testWidgets(), feita justamente para Testes de Widget, diferentemente de test(), usada para Testes de Unidade.

A interface e o comportamento são similares aos da própria função test(): primeiro incluímos uma descrição, e depois um callback. Como nosso objetivo no momento é verificar a exibição da imagem principal, passaremos a descrição "Should display the main imagem when the Dashboard is opened".

Já no callback, também teremos que implementar uma função (), mas desta vez recebendo um argumento WidgetTester, que chamaremos de tester. Em seguida, devolveremos um Future com retorno void usando async/await. Essa é uma maneira bastante comum de implementar o escopo de um Teste de Widget.

void main(){
  testWidgets('Should display the main image when the Dashboard is opened', (WidgetTester tester) async {

  });
}COPIAR CÓDIGO
Preparado o ambiente, precisaremos renderizar um widget antes de qualquer validação. Para esta abordagem, o WidgetTester nos disponibiliza a pumpWidget(), uma função que roda o já conhecido runApp() do Flutter e sobe o widget que queremos testar. Mandaremos para essa função uma instância de Dashboard)(.

void main() {
  testWidgets('Should display the main image when the Dashboard is opened',
      (WidgetTester tester) async {
    tester.pumpWidget(Dashboard());
  });
}COPIAR CÓDIGO
Ao executarmos, o sistema indicará um problema. Isso ocorre porque a implementação de Dashboard() usa um Scaffold() e é chamada pelo ByteBankApp. Este, por sua vez, implementa o MaterialApp(), fazendo com que tudo funcione. Sem essa integração, não conseguiremos subir o Dashboard().

Para contornarmos isso, indicaremos que o Dashboard() deve ser utilizado dentro de MaterialApp(), uma abordagem bastante comum neste tipo de teste. Portanto, usaremos o atalho "Ctrl + Enter", selecionaremos "Wrap with widget" e passaremos o MaterialApp() como componente que envolve o que está sendo testado. Em seguida, substituiremos a propriedade child por home. Assim, não dependeremos mais de BytebankApp() para essa primeira validação.

void main() {
  testWidgets('Should display the main image when the Dashboard is opened',
      (WidgetTester tester) async {
    tester.pumpWidget(MaterialApp(home: Dashboard()));
  });
}COPIAR CÓDIGO
Feito isso, nossa execução não apresentará nenhum problema. Prosseguindo, neste tipo de teste é costumeiro realizar a busca de algum widget usando a referência Finder, que será devolvida com o Widget buscado. Para isso, podemos utilizar funções estáticas a partir de find (de CommonFinders), o qual possui diversos comportamentos que permitem a busca de widgets.

Como queremos procurar um widget do tipo Image, usaremos o find.byType() passando o tipo desejado. Nos será devolvido um Finder que chamaremos de mainImage. Por fim, faremos um expect() passando o mainImage recebido e algum dos matchers disponíves. Nesse caso, nosso objetivo é encontrar apenas um widget, portanto usaremos findsOneWidget.

void main() {
  testWidgets('Should display the main image when the Dashboard is opened',
      (WidgetTester tester) async {
    tester.pumpWidget(MaterialApp(home: Dashboard()));
    final mainImage = find.byType(Image);
    expect(mainImage, findsOneWidget);
  });
}COPIAR CÓDIGO
Ao executarmos o teste, teremos um problema. Isso ocorre pois não estamos esperando o tester.pumpWidget() fazer todas as execuções necessárias antes de realizarmos a busca. Resolveremos o problema com a inclusão de um await, muito comum em execuções do tester.

void main() {
  testWidgets('Should display the main image when the Dashboard is opened',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    final mainImage = find.byType(Image);
    expect(mainImage, findsOneWidget);
  });
}COPIAR CÓDIGO
Dado que agora fizemos todos procedimentos necessários, nosso teste passará sem nenhum problema. Para termos certeza da validação, substituiremos findsOneWidget por findsNothing, indicando que nada deve ser achado.

void main() {
  testWidgets('Should display the main image when the Dashboard is opened',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    final mainImage = find.byType(Image);
    expect(mainImage, findsNothing);
  });
}COPIAR CÓDIGO
Assim, a execução do teste retornará um erro. Poderemos então voltar a usar o findsOneWidget. Conseguimos testar a imagem, e agora criaremos um teste que validará nossa primeira funcionalidade.

Para isso, incluiremos mais um testWidgets() com a mensagem "Should display the first feature when the Dashboard is opened". No callback, escreveremos somente tester (pois é do mesmo tipo de teste do anterior), além de um async indicando que é uma execução assíncrona. Prosseguindo, chamaremos o await tester.pumpWidget() passando o MaterialApp() cuja propriedade home é o Dashboard(), onde realmente faremos a validação.

Uma sugestão é, durante o desenvolvimento, sempre executar o teste com o atalho "Shift + F10", de modo a identificar possíveis falhas e poupar tempo. Continuando, buscaremos nossa funcionalidade com find.byType() passando o _FeatureItem.

Porém, este componente está definido como privado na classe Dashboard. Alteraremos essa característica renomeando-o para FeatureItem com "Shift + F6". Agora que conseguimos acessá-lo, atribuiremos a referência esperada a uma variável firstFeature e executaremos o except() para verificarmos se ele aparece ou não, nesse caso com o findsOneWidget.

Depois colocamos a referência esperada firstFeature com final, seguido de expect() na linha seguinte recebendo firstFeature para verificar se a funcionalidade aparece mesmo ou não. Também como parâmetro, escrevemos o mesmo findsOneWidget para ter o mesmo feedback.

testWidgets('Should display the first feature when the Dashboard is opened',
    (tester) async {
  await tester.pumpWidget(MaterialApp(home: Dashboard()));
  final firstFeature = find.byType(FeatureItem);
  expect(firstFeature, findsOneWidget);
});COPIAR CÓDIGO
Note que a execução desse teste retornará que esperávamos um único widget, mas foi verificada a existência de dois. Nesse tipo de situação, podemos usar o findWidgets, que valida a presença de pelo menos um widget.

testWidgets('Should display the first feature when the Dashboard is opened',
    (tester) async {
  await tester.pumpWidget(MaterialApp(home: Dashboard()));
  final firstFeature = find.byType(FeatureItem);
  expect(firstFeature, findsWidgets);
});COPIAR CÓDIGO
Ao executarmos novamente, o teste passará sem problemas. Aprendemos, então, que durante um Teste de Widget conseguimos realizar várias validações. Como são nossos primeiros testes e não estamos focando tanto em o que faz ou não sentido testar, não precisamos nos preocupar com as verificações que foram feitas, mas sim com possibilidades que temos em relação à maneira como testamos um único widget, como buscamos o que foi apresentado durante a execução do teste e como podemos validá-lo.

Se executarmos todos os testes de uma única vez a partir do main(), receberemos um aviso de que nossa tela que não é flexível o suficiente para acessar todos os componentes. Veremos como resolver este tipo de problema adiante.

@@09
Implementando testes de widget

Crie o arquivo para criar testes de widget para o Dashboard. Então crie os testes para validar os seguintes casos de uso:
Verificar se a imagem principal aparece;
Verificar se a primeira funcionalidade aparece.
Durante a implementação, considere o uso da função find.byType(). Rode ambos os testes e veja funciona como esperado.

A execução separadamente de cada teste deve passar sem problemas. Ao executar ambos os testes ao mesmo tempo, deve apresentar o seguinte problema:
The following assertion was thrown during layout:
A RenderFlex overflowed by 292 pixels on the bottom.COPIAR CÓDIGO
Não se preocupe que resolveremos esse detalhe a seguir.

Você pode conferir o código desta atividade a partir deste commit.

https://github.com/alura-cursos/flutter-tests/commit/057b96229e6afd01111f10b9597af09c82ada3f6

@@10
Para saber mais - Testando tela com Image Network

Executamos o nosso teste a partir de um Image que carrega a imagem por meio de um asset, porém, é muito comum o uso da alternativa via rede:
Image.network('https://image_address.jpg')COPIAR CÓDIGO
Se por algum motivo você tentar executar um teste que receba esse tipo de Widget durante a execução do tester.pumpWidget(), será apresentado um problema do HTTP, pois é um comportamento padrão em testes de widget que evita comunicações externas. Para evitar esse problema, confira esse artigo.

https://iirokrankka.com/2018/09/16/image-network-widget-tests/

@@11
O que aprendemos?

O que aprendemos nessa aula:
Quais são as categorias de testes no Flutter;
A quantidade de implementação de testes recomendada por categoria no Flutter;
O trade-off de cada categoria de teste.
