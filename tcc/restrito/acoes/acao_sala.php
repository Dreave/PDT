<?php
	require('conexao/conecta.php');

	$desc = $_POST['desc'];
	$bloco = $_POST['bloco'];
	$disciplina = $_POST['disciplina'];

	if($disciplina != 0){
		$sql = "INSERT INTO sala(sal_desc, blo_cod, dis_cod) VALUES ('$desc', $bloco, $disciplina)";
	}
	else{
		$sql = "INSERT INTO sala(sal_desc, blo_cod) VALUES ('$desc', $bloco)";
	}

	mysqli_query($con,$sql) or die('Falha ao cadastrar Sala');

	$mensagem = "Sala cadastrada com sucesso";
?>