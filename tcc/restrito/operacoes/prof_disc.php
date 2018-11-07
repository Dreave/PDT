<?php
	require('conexao/conecta.php');

	$id = $_GET['id'];
	$mensagem = null;
	
	$sqlPD = "SELECT * FROM disciplina as d
			INNER JOIN professor_has_disciplina as pd  ON d.dis_cod = pd.dis_cod
			INNER JOIN professor as p ON  pd.pro_cod = p.pro_cod
			WHERE p.pro_cod = $id";
	$resultPD = mysqli_query($con, $sqlPD) or die("Falha ao buscar disciplinas do professor");

	$sql = "SELECT * FROM professor WHERE pro_cod = " . $id;
	$result = mysqli_query($con, $sql) or die("Falha ao buscar nome do professor");
	$professor = mysqli_fetch_array($result);

	$sqlAdd = "SELECT * FROM disciplina";
	$resultAdd = mysqli_query($con, $sqlAdd) or die("Falha ao buscar disciplinas");

	if(isset($_POST['submit'])) {
		include('restrito/acoes/acao_pd.php');
	}

?>
<div>
	<h3>Disciplinas do professor <?= $professor['pro_nome'] ?></h3>
		<table class="table table-hover">
			<tr>
				<th>Disciplina</th>
			</tr>
			<?php
				while($disciplinaProf = mysqli_fetch_array($resultPD)){
					echo "<tr>";
					echo "	<td>" . $disciplinaProf['dis_nome'] . "</td>";
					echo "</tr>";
				}
			?>
		</table>
	<form name="form1" method="post">
		<h4>Conectar professor à disciplina:</h4>
		<div class="form-group">
			<select name="addDisciplina" class="form-control" style="float: left;max-width: 80%">
				<?php
					while($disciplina = mysqli_fetch_array($resultAdd)) {
						echo "<option value='" . $disciplina['dis_cod'];
						/*if(isset($_GET['id'])){
							if($ppc['cur_cod'] == $curso['cur_cod']){
								echo "' selected>" . $curso['cur_nome'] . "</option>";
							}
							else{
								echo "'>" . $curso['cur_nome'] . "</option>";
							}
						}
						else{*/
							echo "'>" . $disciplina['dis_nome'] . "</option>";
						//}
					}
				?>
			</select>
			<a href="?pag=caddisc" class="btn btn-default" style="display: block">Cadastrar disciplina</a>				
		</div>
		<div class="form-group">
			<input type="submit" name="submit" value="Salvar" class="btn btn-default">
		</div>
		<div class="form-group">
			<input type="button" value="Voltar" onclick="window.location='?pag=cadprof'" style="width:100%" class="btn btn-default">
		</div>
	</form>

	<p class="text-success"><?= $mensagem ?></p>

</div>