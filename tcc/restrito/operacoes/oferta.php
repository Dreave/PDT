<?php
	require('conexao/conecta.php');

	$id = $_GET['id'];

	$sqlS = "SELECT * FROM serie";
	$resultS = mysqli_query($con, $sqlS);

	$sqlD = "SELECT * FROM professor_has_disciplina as pd 
			INNER JOIN professor as p ON pd.pro_cod = p.pro_cod
			INNER JOIN disciplina as d ON pd.dis_cod = d.dis_cod ";
	$resultD = mysqli_query($con, $sqlD);

	if(isset($_POST['ano'])){
		require('restrito/acoes/acao_oferta.php');
	}	
?>

<div>
	<h2>Oferta:</h2>
	<form name="form1" method="post">
		<div class="form-group">
			<label for="serie">Série</label>
			<select name="serie" class="form-control">
				<?php 
					while($serie = mysqli_fetch_array($resultS)) {
						echo "<option value='" . $serie['ser_cod'];
						/*if(isset($_GET['id'])){
							if($ppc['cur_cod'] == $curso['cur_cod']){
								echo "' selected>" . $curso['cur_nome'] . "</option>";
							}
							else{
								echo "'>" . $curso['cur_nome'] . "</option>";
							}
						else{*/
							echo "'>Ano de entrada: " . $serie['ser_ano'] . "</option>";
						//}
					}
				?>
			</select>
		</div>
		<div class="form-group">
			<label for="disc">Disciplina</label>
			<select name="disc" id="disc" class="form-control" multiple>
				<?php 
					while($disciplina = mysqli_fetch_array($resultD)) {
						echo "<option value='" . $disciplina['pd_cod'];
						/*if(isset($_GET['id'])){
							if($ppc['cur_cod'] == $curso['cur_cod']){
								echo "' selected>" . $curso['cur_nome'] . "</option>";
							}
							else{
								echo "'>" . $curso['cur_nome'] . "</option>";
							}
						}
						else{*/
							echo "'>" . $disciplina['dis_nome'] . " - Professor: " . $disciplina['pro_nome'] . "</option>";
						//}
					}
				?>
			</select>
		</div>
		<div class="form-group">
			<input type="submit" value="Adicionar" class="btn btn-default" name="add" id="add">
		</div>
		<div class="form-group">
			<label for="ano">Ano</label>
			<input type="text" name="ano" class="form-control" placeholder="Ano" required>
		</div>
		<input type="submit" value="Salvar" class="btn btn-default">
		<input type="button" value="Limpar" class="btn btn-default" onclick="window.location='?pag=oferta">
	</form>
</div>