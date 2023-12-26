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


##### 20/12/2023

@02-Criando testes de widget

@@01
Resolvendo o problema de acesso ao Widget

Neste passo, resolveremos o problema que consiste na execução de todos os testes do Dashboard sem conseguirmos acessar algumas das funcionalidades. Esse problema acontece porque o Dashboard() não possui um scroll, ou seja, qualquer ação feita na tela que suba sua parte inferior, como no caso da abertura do teclado por exemplo, fará o sistema nos alertar de que existe algo inacessível no widget.
Pensando nisso, faz sentido que a solução venha a partir da adição de uma rolagem. Após acessarmos a classe Dashboard, usaremos o atalho "Alt + Enter" e a opção "Wrap with widget" para envolvermos o Column(), que mantém os componentes visuais, com um SingleChildScrollView().

body: SingleChildScrollView(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
//...COPIAR CÓDIGO
Se executarmos o teste após as alterações, ele funcionará corretamente. Entretanto, a tela do aplicativo deixará de apresentar o visual esperado, afinal o SingleChildScrollView() cresce conforme a quantidade de componentes na tela, sem respeitar a configuração feita com mainAxisAlignment.

01-child

Para termos o layout necessário, há uma técnica que modifica a forma como SingleChildScrollView() funciona, fazendo com que ele ocupe exatamente o tamanho da tela. As informações sobre esta configuração são encontradas na documentação do SingleChildScrollView, onde encontraremos um exemplo de sua implementação.

De volta ao Dashboard, envolveremos o SingleChildScrollView() em um LayoutBuilder(). No builder() desse novo widget, implementaremos uma função que recebe um context e uma referência BoxConstraints que chamaremos de constraints. Com uma arrow function, retornaremos o próprio SingleChildScrollView().

body: LayoutBuilder(
  builder: (context, constaints) => SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
//...COPIAR CÓDIGO
A próxima configuração consiste em ajustar o tamanho de SingleChildScrollView() a partir do parâmetro contraints. Para isso, envolveremos o Column() com um ConstrainedBox(), que se tornará filho de SingleChildScrollView(). Nesse novo widget, passaremos a propriedade constraints recebendo uma instância BoxConstraints() que, por sua vez, receberá minHeight com o valor constraints.maxHeight.

body: LayoutBuilder(
  builder: (context, constaints) => SingleChildScrollView(
    child: ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: constaints.maxHeight
      ),
      child: Column(
//...COPIAR CÓDIGO
Ao executarmos a aplicação, nosso emulador passará a exibir a tela com o layout correto.

02-tela

Além disso, como ela possui a propriedade de scroll, nossa bateria de testes não encontrará nenhum problema. A seguir, continuaremos explorando possibilidades durante os nossos testes.

https://api.flutter.dev/flutter/widgets/SingleChildScrollView-class.html

@@2
Resolvendo o problema do Dashboard

Caso precise, no link a seguir, você pode baixar o projeto com todas as alterações realizadas na aula passada.
Para evitar o problema ao executar múltiplos testes no Dashboard, implemente a solução sugerida pela documentação do SingleChildScrollView utilizando o LayoutBuilder.

Após implementar, execute ambos os testes, verifique se ambos passam ao mesmo tempo e confira se o visual do App não foi afetado.

https://github.com/alura-cursos/flutter-tests/archive/aula-1.zip

https://api.flutter.dev/flutter/widgets/SingleChildScrollView-class.html#widgets.SingleChildScrollView.1

Ambos os testes devem passar e o visual do Dashboard não deve ser modificado.
Você pode conferir o código desta atividade a partir deste commit.

https://github.com/alura-cursos/flutter-tests/commit/a3aa313dcd56b9a07608216a81fd3f112b857f87

@@03
Buscando widgets com mais precisão

Com os problemas anteriores resolvidos, partiremos para a avaliação dos testes que fizemos, entendendo se eles fazem sentido em relação ao nosso objetivo. Considerando o primeiro teste, nosso objetivo era validar se a imagem principal é apresentada. Neste caso faz sentido, pois temos apenas uma única imagem em um único widget que é apresentado sem falhas.
Já no segundo teste, verificamos a apresentação da primeira funcionalidade, algo que não possui tanto valor para nosso projeto, já que o Dashboard está sujeito a ter diversos tipos de features. Logo, não há nada descritivo o suficiente para indicar qual é a "primeira" funcionalidade.

Sendo assim, faz mais sentido validarmos se estamos recebendo a funcionalidade esperada, seja "Transfer", a "Transaction Feed", ou ainda qualquer outra que possa ser implementada futuramente. Faremos então a conversão de nosso teste para que consigamos identificar com mais precisão se a funcionalidade de transferência, por exemplo, está sendo apresentado.

O primeiro passo será alterar a descrição do segundo teste para "Should display the transfer feature when the Dashboard is opened". Como as características do "Transfer" são as mesmas do "Transaction Feed", atuaremos precisamente sobre o conteúdo, que é onde eles se diferem. Para buscarmos os conteúdos, usaremos outras funções próprias do Finder, como widgetWithText() e widgetWithIcon(). Elas basicamente recebem o widget que queremos testar e verificam se o conteúdo dentro dele é um texto ou um ícone, respectivamente.

Começaremos pelo ícone Icons.monetization_on, que passaremos para o widgetWithIcon() juntamente com o FeatureItem.

testWidgets('Should display the first feature when the Dashboard is opened',
    (tester) async {
  await tester.pumpWidget(MaterialApp(home: Dashboard()));
  final firstFeature = find.widgetWithIcon(FeatureItem, Icons.monetization_on);
  expect(firstFeature, findsWidgets);
});COPIAR CÓDIGO
Nosso teste ocorrerá como esperado, afinal o ícone passado realmente existe na tela. Se passarmos outro ícone qualquer e executarmos novamente, teremos um problema. Antes de continuarmos, alteraremos o nome da variável firstFeature para iconTransferFeatureItem, de modo a explicitarmos o que ela realmente representa.

testWidgets('Should display the transfer feature when the Dashboard is opened',
    (tester) async {
  await tester.pumpWidget(MaterialApp(home: Dashboard()));
  final iconTransferFeatureItem = find.widgetWithIcon(FeatureItem, Icons.monetization_on);
  expect(iconTransferFeatureItem, findsWidgets);
});COPIAR CÓDIGO
Continuando, incluiremos uma validação para o conteúdo do texto com widgetWithText() recebendo a string "Transfer". Note que devemos tomar bastante cuidado, pois o texto deve ser exatamente o que aparece na tela. Retornaremos a verificação a uma variável nameTransferFeatureItem e faremos o expect() passando nameTransferFeatureItem e, agora que estamos buscando algo único na tela, findsOneWidget.

testWidgets('Should display the transfer feature when the Dashboard is opened',
    (tester) async {
  await tester.pumpWidget(MaterialApp(home: Dashboard()));
  final iconTransferFeatureItem = find.widgetWithIcon(FeatureItem, Icons.monetization_on);
  expect(iconTransferFeatureItem, findsOneWidget);
  final nameTransferFeatureItem = find.widgetWithText(FeatureItem, 'Transfer');
  expect(nameTransferFeatureItem, findsOneWidget);
});COPIAR CÓDIGO
Desta forma, nossa validação e feedback estarão bem mais precisos e nossa aplicação mais segura. Lembrando que, ao fazermos novos testes, é sempre interessante inserir um conteúdo errado para nos certificarmos se a própria verificação está funcionando.

Perceba que é importante identificar exatamente o que se deseja testar, de modo que as validações sirvam para confirmar se o nosso negócio está sendo apresentado corretamente.

@@04
Verificando a existência da funcionalidade

Modifique o teste que verifica a existência da primeira funcionalidade para que valide a existência da funcionalidade de transferência.
Para isso, use as seguintes funções para o Finder:

find.widgetWithIcon para buscar o ícone da funcionalidade;
find.widgetWithText para buscar o texto da funcionalidade.
Após ajuste, rode o teste e confira se passa conforme o esperado

O teste deve passar sem problemas. Você pode conferir o código desta atividade a partir deste commit.

https://github.com/alura-cursos/flutter-tests/commit/fa77feead665ec4bf2d34fe1873ba24fec3af643

@@05
Buscando widgets com predicate

Anteriormente, conseguimos validar a funcionalidade de transferir para um contato com mais precisão. Neste passo, validaremos o "Transaction Feed" (ou "lista de transferências") da mesma maneira. Seguiremos a mesma metodologia aplicada na etapa anterior, o que nos traz a possibilidade de simplesmente copiarmos e colarmos o código, efetuando em seguida algumas modificações. Nesse caso, alteraremos a descrição, o ícone e o texto que é verificado.
testWidgets('Should display the transfer feature when the Dashboard is opened',
    (tester) async {
  await tester.pumpWidget(MaterialApp(home: Dashboard()));
  final iconTransferFeatureItem = find.widgetWithIcon(FeatureItem, Icons.monetization_on);
  expect(iconTransferFeatureItem, findsOneWidget);
  final nameTransferFeatureItem = find.widgetWithText(FeatureItem, 'Transfer');
  expect(nameTransferFeatureItem, findsOneWidget);
});
testWidgets('Should display the transaction feed feature when the Dashboard is opened',
    (tester) async {
  await tester.pumpWidget(MaterialApp(home: Dashboard()));
  final iconTranssactionFeedFeatureItem = find.widgetWithIcon(FeatureItem, Icons.description);
  expect(iconTranssactionFeedFeatureItem, findsOneWidget);
  final nameTransactionFeedFeatureItem = find.widgetWithText(FeatureItem, 'Transaction Feed');
  expect(nameTransactionFeedFeatureItem, findsOneWidget);
});COPIAR CÓDIGO
Se executarmos os testes, o sistema buscará e encontrará a feature com as características estabelecidas sem problemas. Porém, há um detalhe interessante que devemos nos atentar para termos o benefício de avaliar e conseguir reutilizar nossos códigos. Note que foi fácil testarmos o nosso widget usando "Ctrl + C > Ctrl + V", mas e se tivéssemos widgets mais complexos e com mais conteúdos para serem verificados?

Existe uma alternativa de busca usando Finder que nos permite encontrar exatamente as features com as características desejadas com apenas uma única chamada. Começando de forma didática, comentaremos todo o bloco de código relativo à criação e verificação de iconTransferFeatureItem.

Ainda nesse testWidgets(), nossa intenção é encontrarmos todo o FeatureItem representado pela transferência, e não somente o texto ou o ícone. Sendo assim, criaremos uma variável transferFeatureItem recebendo o retorno de find.byWidgetPredicate(), que nos possibilita implementar uma função que recebe um widget e devolve um valor booleano indicando se ele foi encontrado ou não.

No escopo da função, retornaremos false, o valor padrão indicando que o widget buscado não foi encontrado. Usaremos o if para verificar se o widget recebido faz parte de FeatureItem. Em seguida, continuaremos verificando cada uma das propriedades retornando outras expressões booleanas, como widget.name == 'Transfer' e widget.icon == Icons.monetization_on.

testWidgets('Should display the transfer feature when the Dashboard is opened',
    (tester) async {
  await tester.pumpWidget(MaterialApp(home: Dashboard()));
  final transferFeatureItem = find.byWidgetPredicate((widget) {
    if(widget is FeatureItem) {
      return widget.name == 'Transfer' && widget.icon == Icons.monetization_on;
    }
    return false;
  });
});COPIAR CÓDIGO
No expect(), verificaremos se o transferFeatureItem fruto da análise acima é encontrado somente uma vez usando o findsOneWidget.

testWidgets('Should display the transfer feature when the Dashboard is opened',
      (tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    final transferFeatureItem = find.byWidgetPredicate((widget) {
      if(widget is FeatureItem) {
        return widget.name == 'Transfer' && widget.icon == Icons.monetization_on;
      }
      return false;
    });
    expect(transferFeatureItem, findsOneWidget);
  });COPIAR CÓDIGO
Executando o código, veremos que nosso teste funciona como deveria. Modificando algum valor, como "Transfers" em widget.name, o teste retornará um erro. Assim, temos que o byWidgetPredicate() passa por todos os componentes de uma árvore de widgets e, ao devolver um true, informa que encontrou algo.

Isso pode ser testado adicionando um return true ao nosso código antes mesmo de qualquer validação, o que causará um erro informando que muitos widgets correspondentes foram encontrados (já que todos os existentes retornarão verdadeiro). Feitas essas verificações, podemos apagar o código que havíamos comentado anteriormente.

Agora que entendemos o byWidgetPredicate(), podemos realizar a conversão no teste do "Transaction Feed". Porém, não parece apropriado simplesmente copiarmos e colarmos esse código, pois faz mais sentido extraí-lo para uma função. Começaremos selecionando todo o código de if até o ponto em que retornamos false e usando "Ctrl + Alt + M" para extrair um método featureItemMatcher().

bool featureItemMatcher(Widget widget) {
  if(widget is FeatureItem) {
    return widget.name == 'Transfer' && widget.icon == Icons.monetization_on;
  }
  return false;
}COPIAR CÓDIGO
Para que possamos reutilizá-lo, indicaremos que tanto o nome quanto o ícone serão recebidos via parâmetro. Em seguida, modificaremos os conteúdos hard-code no retorno de modo a passarmos diretamente as variáveis recebidas no método.

bool featureItemMatcher(Widget widget, String name, IconData icon) {
  if(widget is FeatureItem) {
    return widget.name ==  name && widget.icon == icon;
  }
  return false;
}
COPIAR CÓDIGO
Desta forma, na primeira chamada de featureItemMatcher(), passaremos a enviar o widget, a string "Transfer" e o ícone Icons.monetization_on. Como essa é uma chamada de uma única linha, alteraremos o corpo da função para uma arrow function.

testWidgets('Should display the transfer feature when the Dashboard is opened',
      (tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    final transferFeatureItem = find.byWidgetPredicate((widget) => featureItemMatcher(widget, 'Transfer', Icons.monetization_on));
    expect(transferFeatureItem, findsOneWidget);
  });COPIAR CÓDIGO
Na segunda busca, ao invés de executarmos todo o bloco de código anteriormente, buscaremos o transactionFeedFeatureItem a partir do byWidgetPredicate(), novamente usando uma arrow function para executar o método featureItemMatcher com os valores widget, 'Transaction Feed', Icons.description.

testWidgets('Should display the transfer feature when the Dashboard is opened',
    (tester) async {
  await tester.pumpWidget(MaterialApp(home: Dashboard()));
  final transferFeatureItem = find.byWidgetPredicate((widget) => featureItemMatcher(widget, 'Transfer', Icons.monetization_on));
  expect(transferFeatureItem, findsOneWidget);
});
testWidgets('Should display the transaction feed feature when the Dashboard is opened',
    (tester) async {
  await tester.pumpWidget(MaterialApp(home: Dashboard()));
  final transactionFeedFeatureItem = find.byWidgetPredicate((widget) => featureItemMatcher(widget, 'Transaction Feed', Icons.description));
});COPIAR CÓDIGO
Ao executarmos o teste, teremos o retorno esperado. Perceba que é possível explorar cada vez mais o Finder, pois ele nos disponibiliza diversas funcionalidade com comportamentos similares, mas com peculiaridades que facilitam bastante o processo.

@@06
Utilizando o predicate no teste

Ajuste o teste para que, em vez de fazer a busca do ícone e texto, busque diretamente o FeatureItem com o ícone e texto esperado. Para isso, utilize o find.byWidgetPredicate().
Em seguida, crie um teste para validar a existência da funcionalidade que lista as transferências.

Nesse segundo teste, reutilize o mesmo código usado no teste que valida a funcionalidade de transferência. Para isso, extraia a lógica do predicate e reutilize no novo teste.

Rode ambos os testes e verifique se passa conforme o esperado.

Os testes devem passar sem problemas. Você pode conferir o código desta atividade a partir deste commit.

https://github.com/alura-cursos/flutter-tests/commit/b6b02fa1f9d0d2fdfdf4b20049242122e1dae6c2

@@07
Para saber mais - Outros Finders comuns

Além dos finders que utilizamos até o momento, existem outros que podem ser utilizados durante o teste de widgets. Caso tenha interesse explore as possibilidades consultando a documentação.

https://api.flutter.dev/flutter/flutter_test/CommonFinders-class.html

@@08
O que aprendemos?

O que aprendemos nesta aula:
Adicionar scroll no Widget ocupando a tela inteira;
Utilizar outros finders para buscas específicas;
Reutilizar lógica do finder com predicate.

##### 21/12/2023

@03-Implementando teste de fluxo

@@01
Começando o teste de fluxo

Na etapa anterior, aprendemos a criar Testes de Widgets para validar alguns componentes do nosso Dashboard, e o próximo passo será gerar um teste capaz de validar um fluxo inteiro. Em especial, focaremos na implementação da criação de contatos pelo botão "Create" do formulário, acessível ao clicar no container de "Transfer" na tela inicial e depois no Floating Action Button da lista de contatos.
O botão"Create" envia as informações dos campos preenchidos ao banco de dados interno e imprime o novo item na lista da tela anterior. Portanto, verificaremos se o contato esperado realmente foi criado.

O primeiro passo será criar um novo arquivo save_contact_flow.dart para receber todo o código desta verificação. Este teste será exatamente o mesmo visto com os widgets anteriores, mas com algumas peculiaridades durante sua execução.

Começamos com a classe main() seguida de testWidgets()recebendo a descrição simples "Should save an contact". No callback, passaremos o tester e definiremos o async antes do escopo da função.

Sabendo que iremos testar o fluxo inteiro, é ideal utilizarmos tudo o que foi feito desde o início do aplicativo pelo BytebankApp(). Portanto, escrevemos await seguido de tester.pumpWidget() chamando BytebankApp(), o widget inicializa a aplicação.

Primeiramente, queremos verificar se o Dashboard() realmente foi apresentado, considerando o fluxo original. Para isso, indicaremos uma variável dashboard recebendo o find.byType(), que então buscará pelo Dashboard que deve aparecer ao longo da árvore de widgets apresentada pelo BytebankApp().

Em seguida, adicionaremos o expect() recebendo a variável dashboard e a instrução findsOneWidget, afinal esse componente deve aparecer somente uma vez.

void main(){
  testWidgets('Should save a contact', (tester) async {
    await tester.pumpWidget(BytebankApp());
    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);
  });
}COPIAR CÓDIGO
Ao executarmos o teste, teremos um feedback positivo. O próximo passo será fazer o clique diretamente no FeatureItem, sendo necessário encontrar o transferFeatureItem com find.byWidgetPredicate(). Da mesma maneira que anteriormente, passaremos um widget como parâmetro seguido de uma arrow function que chama o featureItemMatcher().

void main(){
  testWidgets('Should save a contact', (tester) async {
    await tester.pumpWidget(BytebankApp());
    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    final transferFeatureItem = find.byWidgetPredicate((widget) => featureItemMatcher(widget, name, icon))
  });
}COPIAR CÓDIGO
Como estamos reutilizando este código, não faz muito sentido mantê-lo dentro do arquivo dashboard_widget_test.dart. Portanto, geraremos um novo documento matchers.dart. Assim, qualquer matcher reutiliável poderá ser adicionado neste arquivo, "limpando" aqueles usados somente para teste.

Pensando nisso, copiaremos todo o bloco da funçãofeatureItemMatcher() e colaremos no arquivo matchers.dart, fazendo as importações dos pacotes dashboard e material para compilar o código. Depois, voltaremos aos arquivos que utilizam essa função e importaremos o novo matchers.dart. Futuramente, após construirmos nossos testes, focaremos mais na organização do código.

De volta ao save_contact_flow.dart, mandaremos para a chamada de featureItemMatcher os parâmetros widget, 'Transfer' e Icons.monetization_on. Em seguida, verificaremos se o "Transfer" é visível com expect() recebendo os parâmetros necessários.

void main(){
  testWidgets('Should save a contact', (tester) async {
    await tester.pumpWidget(BytebankApp());
    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    final transferFeatureItem = find.byWidgetPredicate((widget) => featureItemMatcher(widget, 'Transfer', Icons.monetization_on));
    expect(transferFeatureItem, findsOneWidget);
  });
}COPIAR CÓDIGO
Encontrado o transferFeatureItem, precisaremos fazer alguma ação para que consigamos seguir com o fluxo, que nesse caso é o clique no botão de "Transfer". Para efetuarmos essa verificação usando o framework de teste do Flutter, usaremos o tester, que também disponibiliza comportamentos relacionados a ações, como o tap(). Ele nos permite passar como argumento um Finder, nesse caso otransferFeatureItem.

final transferFeatureItem = find.byWidgetPredicate((widget) => featureItemMatcher(widget, 'Transfer', Icons.monetization_on));
expect(transferFeatureItem, findsOneWidget);
tester.tap(transferFeatureItem);COPIAR CÓDIGO
Nosso teste continuará executando sem nenhum problema. Prosseguindo, esperamos que o botão direcione à lista de contatos. Da mesma maneira como encontramos o Dashboard(), nosso próximo passo será encontrar a contactsList com find.byType(). Em seguida, verificaremos sua presença com expect() e executaremos o teste.

  final transferFeatureItem = find.byWidgetPredicate((widget) => featureItemMatcher(widget, 'Transfer', Icons.monetization_on));
  expect(transferFeatureItem, findsOneWidget);
  tester.tap(transferFeatureItem);
  final contactsList = find.byType(ContactsList);
  expect(contactsList, findsOneWidget);COPIAR CÓDIGO
O retorno indicará uma falha no momento em que usamos o tap(), pois precisamos adicionar o await. É importante saber, que quando trabalhamos com tester, devemos nos lembrar de usar o await para evitar erros comuns.

final transferFeatureItem = find.byWidgetPredicate((widget) => featureItemMatcher(widget, 'Transfer', Icons.monetization_on));
expect(transferFeatureItem, findsOneWidget);
await tester.tap(transferFeatureItem);
final contactsList = find.byType(ContactsList);
expect(contactsList, findsOneWidget);COPIAR CÓDIGO
Entretanto, a próxima execução trará uma nova falha, pois o sistema não conseguiu encontrar o contactsList. Isso acontece porque há um delay entre as várias execuções após o clique em FeatureItem, exigindo diversos passos no framework do Flutter. Neste caso, precisamos que o sistema faça novamente a renderização do widget raiz, que é o BytebankApp, de modo a apresentar a lista de contatos.

Para isso, temos em nosso framework de testes o pump(), que dispara um frame em um determinado período de tempo, realizando as micro tarefas da execução. Dado que estamos usando o tester, usaremos o para segurar a execução até que essas micro tarefas sejam finalizadas.

final transferFeatureItem = find.byWidgetPredicate((widget) => featureItemMatcher(widget, 'Transfer', Icons.monetization_on));
expect(transferFeatureItem, findsOneWidget);
await tester.tap(transferFeatureItem);
await tester.pump();

final contactsList = find.byType(ContactsList);
expect(contactsList, findsOneWidget);COPIAR CÓDIGO
É importante saber que o pump() faz a próxima micro tarefa, então se existirem mais adiante, ele não consegue executá-las para apresentar a tela deseja. Sendo assim, mesmo utilizando-o, continuaremos recebendo um erro informando que a lista de contatos não foi encontrada.

Entretanto, se executarmos o teste novamente, é possível que já tenha terminado as micro tarefas anteriores e apresente a contactsList. Seguiremos nesta abordagem a princípio, mas ela não é a ideal para nosso cenário geral.

Nosso próximo passo será encontrar o Floating Action Button, algo que faremos criando uma variável fabNewContact recebendo a busca de ícone find.widgetWithIcon(). A busca, por vez, receberá o FloatingActionButton e o ícone Icons.add. Em seguida, adicionamos o expect() com os parâmetros específicos desta verificação.

Aplicaremos então o tap(), da mesma maneira que antes, recebendo também o fabNewContact.

final transferFeatureItem = find.byWidgetPredicate((widget) => featureItemMatcher(widget, 'Transfer', Icons.monetization_on));
expect(transferFeatureItem, findsOneWidget);
await tester.tap(transferFeatureItem);
await tester.pump();

final contactsList = find.byType(ContactsList);
expect(contactsList, findsOneWidget);

final fabNewContact = find.widgetWithIcon(FloatingActionButton, Icons.add);
expect(fabNewContact, findsOneWidget);
await tester.tap(fabNewContact);COPIAR CÓDIGO
Para podermos apresentar o formulário, faremos um tester.pump() e criaremos a variável contactForm recebendo a busca find.byType() do ContactForm. Por fim, incluiremos o expect() validando o conteúdo da nova variável com o findsOneWidget.

final fabNewContact = find.widgetWithIcon(FloatingActionButton, Icons.add);
expect(fabNewContact, findsOneWidget);
await tester.tap(fabNewContact);
await tester.pump();

final contactForm = find.byType(ContactForm);
expect(contactsList, findsOneWidget);COPIAR CÓDIGO
Ao executarmos, o sistema retornará uma falha, provavelmente porque o pump() nãõ foi o suficiente. Entretanto, mesmo se adicionarmos diversas chamadas de pump(), não conseguiremos encontrar o formulário.

Isso acontece porque o pump() tem o objetivo de realizar a próxima micro tarefa, mas se houver outra pendente o suficiente para não apresentar a próxima tela, haverá falha. A seguir, veremos que existem alguns outros comportamentos que realizam o pump() e resolvem tudo o que é necessário, com algumas peculiaridades que merecem atenção.

@@02
Testando fluxo com teste de widget

Caso precise, no link a seguir, você pode baixar o projeto com todas as alterações realizadas na aula passada.
Implemente um teste de fluxo para verificar se é possível cadastrar um contato no App.

Durante essa implementação, realize todos os passos até chegar no FAB para criar um novo contato e verificar a existência do formulário de contato.

Rode o teste e veja se tudo funciona até clicar no FAB.

Lembre-se que nesta implementação temos o problema em verificar a existência da tela de formulário de contato.

https://github.com/alura-cursos/flutter-tests/archive/aula-2.zip

O teste deve falhar ao verificar a existência do formulário de contato. A seguir veremos como resolver esse problema.
Você pode conferir o código desta atividade a partir deste commit.

https://github.com/alura-cursos/flutter-tests/commit/8dae5de334a38bbc2834dd1e44d94574fddbcae0

@@03
Utilizando objetos simulados

Durante a execução de nosso teste, tivemos dificuldades para identificar a apresentação do formulário de contatos mesmo após executarmos diversas chamadas do pump(). Isso aconteceu pois ele executa micro tarefas, e não necessariamente resolve todos os problemas pendentes de nosso aplicativo durante o fluxo.
Para resolvê-los, usaremos a função pumpAndSettle(), cujo objetivo é fazer várias chamadas de pump() até que ele solucione as pendências, seja de interações da tela, execuções de Future e assim por diante. Utilizando esta referência, conseguiremos verificar se aquilo que desejamos realmente é apresentado na navegação. Aproveitaremos esse momento e usaremos o pumpAndSettle() também na validação do transferFeatureItem.

void main(){
  testWidgets('Should save a contact', (tester) async {
    await tester.pumpWidget(BytebankApp());
    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    final transferFeatureItem = find.byWidgetPredicate((widget) => featureItemMatcher(widget, 'Transfer', Icons.monetization_on));
    expect(transferFeatureItem, findsOneWidget);
    await tester.tap(transferFeatureItem);
    await tester.pumpAndSettle();

    final contactsList = find.byType(ContactsList);
    expect(contactsList, findsOneWidget);

    final fabNewContact = find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(fabNewContact, findsOneWidget);
    await tester.tap(fabNewContact);
    await tester.pumpAndSettle();

    final contactForm = find.byType(ContactForm);
    expect(contactsList, findsOneWidget);
  });
}COPIAR CÓDIGO
Entretanto, a execução desse teste demorará um tempo maior e nos retornará um erro de timed out. Mas por que isso ocorre? Quando entramos na classe ContactsList, temos acesso ao ContactDao() que realiza a chamada de integração com o banco de dados a partir do FutureBuilder. Essa execução tende a ser feita infinitamente, já que nosso teste é feito na VM de Dart, sem utilizar um emulador, levando à falha da integração, pois não há toda a configuração de ambiente esperada.

Nesta situação, é recomendável simularmos estes comportamentos, sejam eles a integração com um banco de dados ou uma Web API, de modo que eles não aconteçam de verdade. Ou seja, teremos uma implementação equivalente a essas interfaces, tanto com o que chamamos quanto ao que devolvemos, mas que não serão realizadas de fato. Este é um recurso bastante comum quando trabalhamos com testes, principalmente os mais próximos aos Testes de Unidade, que são rápidos e não possuem tantas integrações.

Na documentação do Flutter, há uma página específica sobre mocks, também conhecidos como mock objects ou objetos simulados. Eles são usados quando temos um ambiente no qual ficamos suscetíveis a chamadas de um banco de dados de uma Web API, e que tendem a deixar a execução lenta ou até mesmo apresentar falhas durante os testes.

Um mock pode ser feito manualmente, mas isso tende a dar mais trabalho. Por isso, a própria documentação do Flutter sugere o uso da biblioteca Mockito. Também encontraremos informações sobre os flaky tests, que são justamente testes que tendem a ser frágeis durante a execução, já que dependem de alguma integração.

Para evitar estes problemas, manter o teste rápido e conseguir avaliar o fluxo inteiro, aplicaremos este recurso, começando com a adição da biblioteca mockito ao dev_dependencies do arquivo pubspec.yaml. Em seguida, clicaremos em Packages get" para baixarmos as dependências e termos acesso aos comportamentos e classes desse pacote.

Criaremos então, no diretório "test", o arquivo mocks.dart que será responsável pelos mocks. No novo documento, criaremos uma nova classe MockContactsDao, que possui um prefixo indicando o que ela representa e um sufixo indicando a classe que ela irá mockar. Na sequência, faremos a extensão extends da classe Mock e implementaremos a classe ContactDao.

class MockContactDao extends Mock implements ContactDao {

}COPIAR CÓDIGO
Desta forma, já temos a capacidade de criar uma classe compatível ao ContactDao(), mas cujos comportamentos não serão usados de fato.

Com o objeto mockado, precisamos criar uma instância de MockContactsDao e mandá-la diretamente ao ContactsList. Nessa simulação, nossa única alternativa atualmente é acessarmos o método main() de save_contact_flow.dart e criarmos nele a instância desejada.

void main(){
  testWidgets('Should save a contact', (tester) async {
    final mockContactDao = MockContactDao();
    await tester.pumpWidget(BytebankApp());
    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);
//...COPIAR CÓDIGO
Ao invés disso, usaremos uma técnica conhecida como Injeção de Dependência, que nos permitirá mandar a instância diretamente do BytebankApp, passando pelo Dashboard daí para ContactsList. Ou seja, ao invés da própria classe precisar de alguma referência externa para criar a instância, ela pedirá essa instância.

Começaremos modificando a classe BytebankApp para que ela receba um ContactDao. Em seguida, receberemos esse contactDao como um parâmetro nominal e opcional, usando o @required de modo a estabelecermos que ele seja enviado.

Em seguida, no runApp() do nosso aplicativo, mandaremos uma instância real de ContactDao(). Ou seja, devemos tomar cuidado para não fazer nada inesperado. Ainda nesse arquivo, passaremos contactDao: contactDao() na chamada do Dashboard(), que enviará a instância recebida para aContactsList.

void main() {
  runApp(BytebankApp(contactDao: ContactDao()));
}

class BytebankApp extends StatelessWidget {

  final ContactDao contactDao;

  BytebankApp({@required this.contactDao});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green[900],
        accentColor: Colors.blueAccent[700],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueAccent[700],
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: Dashboard(contactDao: contactDao),
    );
  }
}COPIAR CÓDIGO
Na própria classe Dashboard, criaremos o atributo contactDao que novamente será recebido via construtor. Ao fazermos a chamada do ContactsList() em _showContactsList, mandaremos a mesma instância criada como atributo.

class Dashboard extends StatelessWidget {

  final ContactDao contactDao;
  Dashboard({@required this.contactDao});

//...código omitido 

  void _showContactsList(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ContactsList(contactDao: contactDao),
      ),
    );
  }
//..código omitido
}COPIAR CÓDIGO
Em ContactsList, modificaremos o atributo _dao para contactDao e passaremos a recebê-lo via construtor.

class ContactsList extends StatelessWidget {
  final ContactDao contactDao;

  ContactsList({@required this.contactDao});
//...COPIAR CÓDIGO
Feito este ajuste, recomendamos a executar novamente o aplicativo para conferir se tudo está funcionando como esperado. Caso tudo esteja correto, o componente "Transfer" conseguirá apresentar a lista de contatos sem nenhum problema. Nosso próximo passo será ajustar o teste para que consigamos mandar o objeto mockado.

De volta ao save_contact_flow.dart, passaremos ao BytebankApp() a propriedade contactDao: recebendo o mockContactDao.

void main(){
  testWidgets('Should save a contact', (tester) async {
    final mockContactDao = MockContactDao();
    await tester.pumpWidget(BytebankApp(contactDao: mockContactDao,));
    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);
//...COPIAR CÓDIGO
Terminas essas modificações, nosso teste finalmente será bem sucedido. Quando temos comunicações que exigem uma integração em meio ao fluxo do nosso aplicativo, faz sentido considerarmos o uso de objetos mockados. A seguir, daremos continuidade ao teste até finalizarmos o fluxo e conheceremos técnicas úteis que melhorarão nossa abordagem.

https://flutter.dev/docs/cookbook/testing/unit/mocking

@@04
Implementando mocks com o Mockito

Configure o projeto para que os widgets BytebankApp, Dashboard e ContactList recebam uma referência de ContactDao como dependência.
Em seguida, adicione o mockito ao projeto colocando a dependência no pubspec.yml dentro do script dev_dependencies.

Após baixar a dependência do mockito, crie um objeto simulado para o ContactDao e o envie para o BytebankApp logo no começo do teste ao chamar o pumpWidget. Então ajuste utilize o pumpAndSettle() ao invés dos pump().

Rode o teste novamente e veja se agora ele passa ao verificar a existência do formulário de contato.

O teste deve passar sem apresentar problemas.
Você pode conferir o código desta atividade a partir deste commit.

https://github.com/alura-cursos/flutter-tests/commit/5000dd1fe541220c78de0b836cccec30d8092d44

@@05
Finalizando o fluxo do teste

Agora que nosso teste de fluxo consegue acessar o formulário de contatos, podemos partir para os próximos passos e finalizar esta parte. Testaremos o preenchimento de cada um dos campos e o clique no botão "Create" para ver se o novo item é apresentado na lista.
Adicionaremos um campo nameTextField que buscaremos a partir de find.byWidgetPredicate() enviando uma função que recebe widget e retorna um booleano com o valor padrão false.

Em seguida, validaremos a situação contrária com if(widget is TextField) retornando a expressão widget.decoration.labelText para verificar se esse atributo possui um "Full name". Então, chamaremos expect() passando nameTextField e o matcherfindsOneWidget.

final nameTextField = find.byWidgetPredicate((widget) {
  if(widget is TextField) {
    return widget.decoration.labelText == 'Full name';
  }
  return false;
});
expect(nameTextField, findsOneWidget);COPIAR CÓDIGO
Executando o código após esse novo passo, tudo funcionará corretamente. Continuando, usaremostester.enterText() para adicionarmos um conteúdo, passando a ele o nameTextField e o texto "Alex".

final nameTextField = find.byWidgetPredicate((widget) {
  if(widget is TextField) {
    return widget.decoration.labelText == 'Full name';
  }
  return false;
});
expect(nameTextField, findsOneWidget);
await tester.enterText(nameTextField, 'Alex');COPIAR CÓDIGO
O próximo passo será repetirmos esse processo para o campo "Account number". Para isso, copiaremos e colaremos o código acima e modificaremos as referências onde necessário.

final accountNumberTextField = find.byWidgetPredicate((widget) {
  if(widget is TextField) {
    return widget.decoration.labelText == 'Account number';
  }
  return false;
});
expect(accountNumberTextField, findsOneWidget);
await tester.enterText(accountNumberTextField, '1000');COPIAR CÓDIGO
Com os testes dos campos funcionando, partimos para o botão "Create". Na sequência do código, adicionamos uma variável createButton recebendo a busca find.widgetWithText() para a qual passaremos RaisedButton e 'Create'. Em seguida, faremos a validação com expect() recebendo createButton e findsOneWidget.

Para verificarmos o clique, adicionaremos um await e a execução de tester.tap(createButton).

final createButton = find.widgetWithText(RaisedButton, 'Create');
expect(createButton, findsOneWidget);
await tester.tap(createButton);COPIAR CÓDIGO
Por fim, criaremos uma variável contactsList para a buscafind.byType(). Esta, por sua vez, receberá apenas ContactsList. Entretanto, note que o código não compilará, afinal já fizemos essa busca com o mesmo nome. Pensando nisso, alteraremos a variável para contactsListBack, indicando que é seu retorno. Na sequência, executaremos o expect().

final contactsListBack = find.byType(ContactsList);
expect(contactsListBack, findsOneWidget);COPIAR CÓDIGO
A execução do teste, no entanto, retornará uma falha. Isso faz sentido, pois, no ContactForm, estamos realizando a integração com o banco de dados sem uso da estratégia de Injeção de Dependências, ou seja, nosso mock não está atuando.

Portanto, fazemos a conversão na classe ContactForm adicionando o atributo contactDao que será recebido via construtor e enviado para o _ContactFormState. Nessa classe, modificaremos _dao para contactDao e novamente pediremos que ele seja enviado via construtor.

class ContactForm extends StatefulWidget {

  final ContactDao contactDao;
  ContactForm({@required this.contactDao});

  @override
  _ContactFormState createState() => _ContactFormState(contactDao: contactDao);
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final ContactDao contactDao;

  _ContactFormState({@required this.contactDao});
//...COPIAR CÓDIGO
Também precisaremos passar a nova referência na chamada de ContactForm() da classe ContactsList.

floatingActionButton: FloatingActionButton(
  onPressed: () {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ContactForm(contactDao: contactDao,),
      ),
    );
  },COPIAR CÓDIGO
Após a execução, teremos uma referência nula na execução do then() do nosso ContactForm. Isso ocorre pois estamos tentando executar o retorno, que é um Future. Como ele foi mockado, esse retorno será nulo. A princípio, para resolvermos esse problema, extrairemos essa execução para um método _save() e passaremos a usar o async/await, de modo a dispensarmos a necessidade do then().

void _save(Contact newContact, BuildContext context) async {
  await contactDao.save(newContact);
  Navigator.pop(context);
}COPIAR CÓDIGO
Ainda teremos um erro na busca por ContactsList, que corrigiremos adicionando o pumpAndSettle() ao nosso teste.

final createButton = find.widgetWithText(RaisedButton, 'Create');
expect(createButton, findsOneWidget);
await tester.tap(createButton);
await tester.pumpAndSettle();

final contactsListBack = find.byType(ContactsList);
expect(contactsListBack, findsOneWidget);COPIAR CÓDIGO
Com isso, o teste conseguirá executar todo o fluxo esperado.

@@06
Finalizando os passos do teste de fluxo

Adicione os demais passos para finalizar o teste de fluxo para salvar um contato:
verificar a existência de ambos textfields;
verificar a existência e clique do botão de criação.
Em seguida, ajuste o formulário de contato para que agora ele receba o ContactDao pelo construtor, permitindo o uso do mock. Depois do ajuste, converta o código que chama o save() do ContactDao para que utilize o async await e evite a chamada do then().

Então finalize o fluxo verificando se, ao clicar no botão de criação, a lista de contatos aparece. Por fim, rode o teste e veja se passa sem nenhum problema.

O teste deve passar sem nenhum problema.
Você pode conferir o código desta atividade a partir deste commit.

https://github.com/alura-cursos/flutter-tests/commit/5000dd1fe541220c78de0b836cccec30d8092d44

@@07
Para saber mais - Agrupando testes

Ao escrever testes de Widget, é muito comum a elaboração de mais de um teste para um Widget específico, como por exemplo, o Dashboard.
No exemplo feito em curso, tivemos três testes que mantém o sufixo Dashboard is opended para indicar que é um comportamento do Dashboard, porém, podemos usar um recurso próprio do package de test, o group.

Refatorando o mesmo código para o group, temos o seguinte resultado:

void main() {
  group('When Dashboard is opened', () {
    testWidgets('Should display the main image', (WidgetTester tester) async {
      //test code
    testWidgets('Should display the transfer feature', (tester) async {
      //test code
    testWidgets('Should display the transaction feed feature', (tester) async {
      //test code
    });
  });
}COPIAR CÓDIGO
Ao executar o group() temos o seguinte resultado visual:

Observe que, além de organizar mais o código, a leitura do teste fica mais coerente.

@@08
O que aprendemos?

O que aprendemos nesta aula:
Testar fluxo com teste de Widget;
Configurar Widgets o código para receber dependências;
Utilizar objetos simulados para evitar o código de integração.

#### 23/12/2023

@04-Simulando comportamentos

@@01
Verificando chamadas do banco de dados

Finalizamos o teste de fluxo, mas existem alguns pontos importantes a serem considerados nesta etapa da verificação. Quando realizamos este tipo de teste, passamos por diversos passos do aplicativo para atingir o fluxo esperado, como o de salvar o contato.
Ao acessarmos a lista de contatos, é importante nos certificarmos de que a busca é feita no banco de dados. Por exemplo, se estivermos acessando a tela inicial e clicarmos no botão "Transfer", o aplicativo traz todos os contatos salvos. Devemos garantir que este comportamento pelo menos foi chamado, pois é o que confere valor para nossa usuária ou usuário final.

Mas como faremos isso utilizando objetos simulados? Esse teste será possível verificando as chamadas de funções, uma funcionalidade que o Mockito nos oferece.

Para isso, após garantirmos que a lista de contatos está presente, usaremos o verify(), que é uma função do Mockito. Sua proposta é receber um argumento qualquer e validar se ele foi ou não chamado, ou mesmo quantas vezes ele foi chamado. Passaremos então o MockContactDao e verificaremos se o findAll() foi chamado quando ContactsList é apresentado.

final transferFeatureItem = find.byWidgetPredicate((widget) => featureItemMatcher(widget, 'Transfer', Icons.monetization_on));
expect(transferFeatureItem, findsOneWidget);
await tester.tap(transferFeatureItem);
await tester.pumpAndSettle();

final contactsList = find.byType(ContactsList);
expect(contactsList, findsOneWidget);

verify(mockContactDao.findAll());COPIAR CÓDIGO
Ao executarmos, o teste passará corretamente. Para termos certeza de que tudo funcionou como esperado, usaremos afunção called(), a qual verifica a quantidade de vezes que um comportamento é chamado. Nesse caso, passaremos o valor 0 indicando que o método findAll() não foi chamado nenhuma vez.

verify(mockContactDao.findAll()).called(0);COPIAR CÓDIGO
A execução dessa vez trará um erro, afinal o findAll() é chamado uma única vez. Da mesma forma, se passarmos o valor 2, também receberemos um erro.

No restante do fluxo, entramos na lista de contato, fazemos a interação com o botão de adição e acessamos o formulário. Quando este último é acessado, não há uma execução parecida com a feita na lista, então podemos seguir adiante.

Já em nameTextField, podemos extrair um matcher para o TextField e utilizá-lo tanto no nome quanto no número da conta. Com o atalho "Ctrl + Alt + M", extrairemos o método _textFieldMatcher(), que passará a receber uma string labelText que será retornada na verificação.

bool _textFieldMatcher(Widget widget, String labelText) {
  if(widget is TextField) {
    return widget.decoration.labelText == labelText;
  }
  return false;
}COPIAR CÓDIGO
Em seguida, modificaremos as validações de nameTextField e accountNumberTextField de modo que elas passem a enviar suas respectivas strings ao método criado. Como são chamadas simples, também podemos transformá-las em expressões.

final nameTextField = find.byWidgetPredicate((widget) => _textFieldMatcher(widget, 'Full name'));
expect(nameTextField, findsOneWidget);
await tester.enterText(nameTextField, 'Alex');

final accountNumberTextField = find.byWidgetPredicate((widget) => _textFieldMatcher(widget, 'Account number'));
expect(accountNumberTextField, findsOneWidget);
await tester.enterText(accountNumberTextField, '1000');COPIAR CÓDIGO
Prosseguindo no código, após buscarmos o botão e fazermos uma ação tap(), queremos garantir que a chamada que salva um contato é realizada. Para isso, usaremos novamente o verify(), verificando se o método save() é chamado a partir de mockContactDao. Porém, esse método espera um argumento, no caso um contato com as informações enviadas em cada um dos campos.

Sendo assim, passaremos uma instância de Contact() indicando que o ID é 0 e os argumentos são os mesmos que passamos acima, ou seja, "Aex" e 1000.

final createButton = find.widgetWithText(RaisedButton, 'Create');
expect(createButton, findsOneWidget);
await tester.tap(createButton);
await tester.pumpAndSettle();

verify(mockContactDao.save(Contact(0, 'Alex', 1000)));COPIAR CÓDIGO
Porém, ao executarmos, teremos uma falha, pois o sistema não identificou que o objeto foi enviado, por mais que até indique a chamada de save(). Isso não é necessariamente um problema do teste. Na realidade, queremos validar a igualdade de objetos, o que precisa ser feito com o operador ==.

Da maneira como escrevemos o código, apenas verificamos os endereços reservados em memória, que realmente serão diferentes. Para conseguirmos que eles sejam iguais, acessaremos a classe Contact, utilizaremos o atalho "Alt + Insert" e selecionaremos "==0 and hashCode". Na janela que se abrirá, selecionaremos os critérios de comparação do objeto. Como queremos o nome e o número da conta, selecionaremos esse atributos e clicaremos em "OK".

@override
bool operator ==(Object other) =>
    identical(this, other) ||
    other is Contact &&
        runtimeType == other.runtimeType &&
        name == other.name &&
        accountNumber == other.accountNumber;

@override
int get hashCode => name.hashCode ^ accountNumber.hashCode;COPIAR CÓDIGO
Executando o teste, essa implementação será utilizada como critério de igualdade. Após voltarmos para a lista, queremos garantir que a busca feita no banco de dados também é realizada novamente. Para isso, adicionamos outro verify() usando novamente o mockContactDao e validando se o findAll() é chamado mais uma vez.

verify(mockContactDao.save(Contact(0, 'Alex', 1000)));

final contactsListBack = find.byType(ContactsList);
expect(contactsListBack, findsOneWidget);

verify(mockContactDao.findAll());COPIAR CÓDIGO
Entretanto, teremos um erro indicando que o findAll() não é chamado novamente. Perceba que ContactsList é um StatelessWidget, e não é feito um rebuild na sua execução. Portanto, se quisermos garantir que a chamada no banco de dados e a atualização aconteçam, precisaremos convertê-lo para um StatefulWidget.

Usaremos o atalho "Alt + Enter" e a opção "Convert to StatefulWidget" do próprio IntelliJ e executaremos novamente o teste. Dessa vez, o build será realizado corretamente e a verificação ocorrerá como esperado.

Se você tiver alguma dúvida sobre o funcionamento do aplicativo após as alterações feitas durante os testes, basta executar o fluxo novamente. Note que a mudança para um StatefulWidget não causou nenhum impacto, mas agora garantimos que ela é atualizada conforme esperado.

Dessa forma, finalizamos o teste que garante o fluxo de armazenamento de um contato.

@@02
Utilizando o verify do mockito

Caso precise, no link a seguir, você pode baixar o projeto com todas as alterações realizadas na aula passada.
Ajuste o teste de fluxo para verificar se as chamadas do DAO são invocadas.

Para isso, utilize o verify(), enviando o findAll() como argumento. A verificação precisa ser feita depois de conferir se a lista de contatos está presente.

Verifique também se o save() com o contato esperado é chamado. Para verificar o objeto com os valores esperados, sobrescreva o operador == e o hashcode utilizando a IDE. Ao gerar ambos métodos, lembre-se de selecionar apenas os atributos name e accountNumber.

Em seguida, verifique se o findAll() é chamado novamente ao voltar para a lista de contatos.

Na implementação do curso, o ContactsList estava como StatelessWidget, o que evita a chamada do build() novamente. Portanto, converta para StatefulWidget.
Por fim, confira todo o código de teste e faça extrações de funções para reutilização de código, por exemplo a lógica do predicate do TextField. Rode o teste e veja se funciona como esperado.

https://github.com/alura-cursos/flutter-tests/archive/aula-3.zip

O teste deve passar sem nenhum problema.
Você pode conferir o código desta atividade a partir deste commit

https://github.com/alura-cursos/flutter-tests/commit/ebc53bce9a2f0cf4963ee3123935e0c6fbd91ec9

@@03
Criando o teste de fluxo de transferência

Já aprendemos a criar um teste de fluxo que garante o armazenamento de um contato, e agora podemos partir para o teste que assegura a transferência para um contato.
Nesse fluxo, a partir da tela principal do aplicativo, clicamos em "Transfer" e depois em algum contato da lista. Após isso, preenchemos o campo do formulário com um valor e clicamos no botão "Transfer" desta tela. Com isso, uma janela de autenticação se abre para enviar as informações ao servidor, que então nos devolve um dialog indicando se a transferência foi realizada ou não.

São essas navegações e funcionalidades que desejamos garantir. Antes de começarmos, vamos organizar o código pensando em hierarquia. Primeiro, criamos um novo diretório dentro de "test" chamado "flows", representando nossos fluxos, que receberá o arquivo save_contact_flow.dart.

A próxima pasta, "widget", será criada exclusivamente para os Testes de Widget, no momento contidos apenas em dashboard_widget_test.dart. Em seguida, criaremos o diretório "unit" recebendo os Testes de Unidade feitos no arquivo transaction_test.dart.

Por fim, criaremos os diretórios "matchers" e "mocks" os arquivos com seus respectivos nomes. Desta maneira, nosso projeto estará melhor organizado e poderemos prosseguir com o novo teste.

Começaremos criando um arquivo transfer_flow.dart na pasta "flows". Neste, seguiremos a mesma metodologia aplicada no primeiro fluxo com as funções main() e testWidgets(). Teremos a descrição "Should transfer to a contact" e implementaremos um callback recebendo tester e abrindo o escopo com async.

void main(){
  testWidgets('transfer to a contact', (tester) async {

  });
}COPIAR CÓDIGO
O fluxo de criação de uma transferência é igual ao de armazenar um contato até um determinado ponto, que é a exibição da lista de contatos. Sendo assim, copiaremos o bloco de código responsável por essa validação em save_contact_flow.dart, o colaremos no novo arquivo e faremos as importações necessárias.

void main(){
  testWidgets('transfer to a contact', (tester) async {
    final mockContactDao = MockContactDao();
    await tester.pumpWidget(BytebankApp(contactDao: mockContactDao,));
    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    final transferFeatureItem = find.byWidgetPredicate((widget) => featureItemMatcher(widget, 'Transfer', Icons.monetization_on));
    expect(transferFeatureItem, findsOneWidget);
    await tester.tap(transferFeatureItem);
    await tester.pumpAndSettle();

    final contactsList = find.byType(ContactsList);
    expect(contactsList, findsOneWidget);

  });
}COPIAR CÓDIGO
Executando o teste, ele passará como esperado. Aproveitaremos esse momento de organização do código para reaproveitarmos algumas interações que são feitas, como aquela na qual fazemos um clique e buscamos um FeatureItem. Selecionaremos esse trecho do código e usaremos "Ctrl + Alt + M" para criarmos o método clickOnTheTransferFeatureItem()

Future clickOnTheTransferFeatureItem(WidgetTester tester) async {
  final transferFeatureItem = find.byWidgetPredicate((widget) => featureItemMatcher(widget, 'Transfer', Icons.monetization_on));
  expect(transferFeatureItem, findsOneWidget);
  await tester.tap(transferFeatureItem);
}COPIAR CÓDIGO
No diretório "flows", criaremos um novo arquivo actions.dart para o qual passaremos a função criada. Esse nome de arquivo não é padrão, e, se você preferir, pode utilizar outros, como interactions ou events. Faremos as importações necessárias e passaremos a utilizar a nova função em transfer_flow.dart e save_contact_flow.dart.

void main(){
  testWidgets('transfer to a contact', (tester) async {
    final mockContactDao = MockContactDao();
    await tester.pumpWidget(BytebankApp(contactDao: mockContactDao,));
    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    await clickOnTheTransferFeatureItem(tester);
    await tester.pumpAndSettle();
//...COPIAR CÓDIGO
void main(){
  testWidgets('Should save a contact', (tester) async {
    final mockContactDao = MockContactDao();
    await tester.pumpWidget(BytebankApp(contactDao: mockContactDao,));
    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    await clickOnTheTransferFeatureItem(tester);
    await tester.pumpAndSettle();
//...COPIAR CÓDIGO
Na função clickOnTheTransferFeatureItem(), perceba que ainda estamos usando o await, quando podemos simplesmente retornar o tester.tap().

Future<void> clickOnTheTransferFeatureItem(WidgetTester tester) async {
  final transferFeatureItem = find.byWidgetPredicate((widget) => featureItemMatcher(widget, 'Transfer', Icons.monetization_on));
  expect(transferFeatureItem, findsOneWidget);
  return tester.tap(transferFeatureItem);
}COPIAR CÓDIGO
Assim, nosso retorno será um Future<void>, e o responsável por garantir ou não o tipo esperado é quem fizer a chamada, no caso transfer_flow e save_contact_flow.dart. Executaremos novamente os testes para garantirmos que eles continuam com o comportamento esperado, e a seguir continuaremos criando o teste de fluxo de transferência.

@@04
Organizando o projeto

Organize o código de teste para que cada arquivo fique dentro do seu diretório. Para isso, crie os seguintes diretórios:
flows;
matchers;
mocks;
unit;
widgets.
Em seguida, mova os arquivos nos seus devidos diretórios e crie o arquivo para o novo teste de fluxo, garantindo o comportamento de transferir para um contato.

Adicione o código de teste até validar que, a partir do Dashboard, chega até a lista de contatos. Também verifique se o findAll() do DAO é chamado.

Dica: copie o código do teste de fluxo para adicionar um contato até o momento que verifica a presença da lista de contatos.
Por fim, execute o teste de fluxo da transferência e confira se passa.

https://github.com/alura-cursos/flutter-tests/commit/d91f21cc1430c2be3e91a807d32092cce679920e

@@05
Adicionando comportamentos nos moc

Fizemos a primeira parte do teste de fluxo que garante a transferência para um contato, e agora daremos continuidade à interação dentro da lista de contatos - interação essa consiste em clicar em um dos itens para acessar o formulário que permite a ação de transferir.
Depois de verificarmos que o método findAll() é executado,, criaremos um contactItem realizando a busca com find.byWidgetPredicate(), da mesma maneira feita em TransferFeatureItem. Neste, receberemos widget e retornaremos por padrão um false. Em seguida, usaremos o if() para provar o contrário, passando as características do ContactItem esperado.

Para isso, precisamos fazer com que _ContactItem seja público, pois no momento é uma classe privada. Com "Shift + F6", removeremos o _ para torná-la pública. Com acesso ao ContactItem, verificaremos se o nome e o número da conta batem com o esperado. Nessa simulação, usaremos o nome "Alex" e número "1000". Por fim, faremos o expect() passando o contactItem recebido e o findsOneWidget.

final contactItem = find.byWidgetPredicate((widget) {
  if(widget is ContactItem) {
    return widget.contact.name == 'Alex' && widget.contact.accountNumber == 1000;
  }
  return false;
});
expect(contactItem, findsOneWidget);COPIAR CÓDIGO
Ao executarmos, teremos uma falha indicando que o widget não foi encontrado. Isso é esperado, pois quando usamos mocks, não temos a chamada de integração da busca no banco de dados. Precisamos fazer uma configuração a mais para que consigamos simular o retorno do contato esperado no momento em que findAll() é executado. Desta maneira, conseguiremos usar o fluxo que pega a informação e dar continuidade ao processo.

Para isso, usamos algumas chamadas do próprio mockito, prestando atenção ao fato de que essa configuração deverá ser feita exatamente antes da execução de findAll(), ou seja, precisamos configurar em um ponto do código onde temos certeza de não ter executado o findAll() ainda - nesse teste, antes de clickOnTheTransferFeatureitem().

Faremos a chamada de when(), do próprio mockito, que indica uma ação tomada antes de um acontecimento, nesse caso quando o mockContactDao chamar o findAll(). O mockito nos disponibiliza diversas possibilidades de funções, como thenAnswer(), thenReturn() e thenThrow().

O thenThrow() basicamente lança uma exceção, servindo para simular erros no aplicativo; o thenReturn() retorna o valor nesta função; e o thenAnswer() atribui uma função para aquela que estamos utilizando no ponto da chamada. Por exemplo, no momento da chamada do findAll(), poderíamos utilizar o thenAnswer() para executar um Future ou algo do gênero.

Usaremos o thenAnswer() para simular a execução do banco de dados, que é um Future. Portanto, indicaremos este Future devolvendo o valor diretamente, sem nenhuma execução. Na implementação do thenAnswer(), basicamente receberemos uma função que possui um tipo Invocation e precisa retornar o mesmo valor utilizado na chamada, que seria um Future<ContactsList>.

Passaremos então o invocation e usaremos o async/await na definição do escopo da função, onde simplesmente retornaremos uma lista vazia. Dentro dela, passaremos um contato.

when(mockContactDao.findAll()).thenAnswer((invocation) async {
  return [Contact(0, 'Alex', 1000)];
});
await clickOnTheTransferFeatureItem(tester);
await tester.pumpAndSettle();COPIAR CÓDIGO
O invocation é basicamente a chamada da função findAll(). Para termos certeza disso, podemos fazer um debugPrint() indicando 'name invocation' pegando sua propriedade invocation.memberName com a sintaxe ${}.

when(mockContactDao.findAll()).thenAnswer((invocation) async {
  debugPrint('name invocation ${invocation.memberName}');
  return [Contact(0, 'Alex', 1000)];
});COPIAR CÓDIGO
Feita a modificação do fluxo, executaremos este teste, que passará corretamente retornando que o nome da invocação é justamente o findAll. Sendo assim, podemos remover o debugPrint() do código.

O próximo passo será verificarmos se o clique dá acesso ao formulário de criação de transferência. Para isso, faremos um await tester.tap() passando o contactItem, além de um await pumpAndSettle(). Em seguida, criaremos a variável transactionForm recebendo o find.byType() que buscará pelo TransactionForm. Por fim, validaremos com o expect().

expect(contactItem, findsOneWidget);
await tester.tap(contactItem);
await tester.pumpAndSettle();

final transactionForm = find.byType(TransactionForm);
expect(transactionForm, findsOneWidget);COPIAR CÓDIGO
Esse teste também será executado com sucesso. Antes de continuarmos, vamos a um ponto importante: no formulário da transação não existem problemas visuais neste momento, mas em seu código temos uma dependência de _webClient, da mesma maneira que tivemos em ContactForm. Ou seja, faz sentido considerarmos todas a técnica de injeção de dependência.

Porém, se fizermos isso com o TransactionWebClient(), nosso código ficará cada vez mais poluído e difícil de manter. A seguir, conheceremos uma nova técnica sobre este tipo de abordagem, justamente para evitar manutenções desnecessárias a cada nova dependência.

@@06
Avançando o fluxo até o formulário

Adicione o código de teste para o fluxo do App avançar até o formulário de transferência.
Para isso, utilize o thenAnswer() após chamar o when() com o findAll() como argumento. Então devolva um Future<List<Contact>> que tenha pelo menos um contato.

Em seguida, modifique o código para identificar um contato e clicar no ContactItem dele.

Se o ContactItem estiver privado, ajuste-o para que seja público.
Por fim, verifique se a tela de formulário da transferência é apresentada e rode o teste.

O teste deve passar sem nenhum problema. Você pode conferir o código desta atividade a partir deste commit.

https://github.com/alura-cursos/flutter-tests/commit/84855b7bd75b3f31986e0c82fc8b40c6abf4b202

@@07
Para saber mais - setup e teardown nos testes

Durante a execução do teste de fluxo, precisamos enviar o dao mockado como dependência do nosso Widget. Esse tipo de abordagem é muito comum para qualquer teste de Widget que faz uso de integração.
Em um único teste com uma única dependência não temos tanto impacto no código, porém, ao criar mais testes que precisam da mesma ou mesmas dependências do anterior, temos o seguinte código de inicialização dos testes:

void main() {
  testWidgets('Should save a contact', (tester) async {
    final mockContactDao = MockContactDao();
    await tester.pumpWidget(BytebankApp(
      contactDao: mockContactDao,
    ));

    //test code
  });
  testWidgets('Should save contacts', (tester) async {
    final mockContactDao = MockContactDao();
    await tester.pumpWidget(BytebankApp(
      contactDao: mockContactDao,
    ));

    //test code
  });
}COPIAR CÓDIGO
Um boilerplate que tende aumentar caso o Widget dependa de mais objetos!

Para evitar esse boilerplate, podemos utilizar um recurso conhecido como setup que tem o objetivo de inicializar a configuração dos testes.

Isso significa que o setup é sempre executado cada vez que um teste rodar. Considerando o seu uso, temos o seguinte resultado:

void main() {
  MockContactDao mockContactDao;

  setUp(() async {
    mockContactDao = MockContactDao();
  });

  testWidgets('Should save a contact', (tester) async {
    await tester.pumpWidget(BytebankApp(
      contactDao: mockContactDao,
    ));

    //test code
  });

  testWidgets('Should save contacts', (tester) async {
    final mockContactDao = MockContactDao();
    await tester.pumpWidget(BytebankApp(
      contactDao: mockContactDao,
    ));

    //test code
  });
}COPIAR CÓDIGO
Dessa forma, para cada teste executado, temos uma instância nova das dependências e a responsabilidade de inicialização fica por conta do setup, o que facilita também a leitura de teste.

Além do setup, também temos o teardown que é um recurso de pós execução de cada teste muito utilizado para encerrar rotinas, como por exemplo, num teste de integração que usa um banco de dados real e precisa limpar. Na própria documentação é apresentado um exemplo.

@@08
O que aprendemos?

O que aprendemos nesta aula:
Verificar chamadas de métodos de objetos simulados;
Gerar código automático do operador == e o hashcode;
Finalizar um teste de fluxo.