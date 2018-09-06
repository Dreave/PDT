<?php
  $active['home'] = '';
  $active['jogo'] = '';
  $active['selecoes'] = '';
  $active['jogadores'] = '';

  if(isset($_GET['pag'])){
    $active[$_GET['pag']] = 'active';
  }
  else{
    $active['home'] = active;
  }
?>

    <nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">GerAcad</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li class='<?= $active['home'] ?>'><a href="#">Home</a></li>
            <li class='<?= $active['jogo'] ?>'><a href="?pag=horario">Horários</a></li>
            <li class='<?= $active['selecoes'] ?>'><a href="?pag=selecoes">Cadastros</a></li>
            <li class='<?= $active['jogadores'] ?>'><a href="?pag=jogadores">Portal do professor</a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>