<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Articulos</title>
<!-- ContextPath setting in css, DO NOT TOUCH!!! -->
<style>
    :root {
        --contextPath: "${pageContext.request.contextPath}";
    }
</style>

<!-- STYLESHEETS -->
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/bootstrap.css"/>'>
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/articulos.css"/>'>
<link href="https://cdn.datatables.net/v/bs5/jq-3.6.0/dt-1.13.4/datatables.min.css" rel="stylesheet"/>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300&display=swap" rel="stylesheet">

<!-- Enlace al archivo CSS de Font Awesome -->
<link rel="stylesheet" href='<c:url value="/resources/fontawesome/css/all.min.css"/>'>

<!-- Enlace opcional a los archivos de fuentes de Font Awesome -->
<link rel="stylesheet" href='<c:url value="/resources/fontawesome/webfonts/fa-brands-400.woff2"/>'>
<link rel="stylesheet" href='<c:url value="/resources/fontawesome/webfonts/fa-regular-400.woff2"/>'>
<link rel="stylesheet" href='<c:url value="/resources/fontawesome/webfonts/fa-solid-900.woff2"/>'>
<!-- Agrega los estilos CSS de Toastr -->
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">




<!-- scripts -->
<script type="text/javascript" src="https://cdn.datatables.net/v/bs5/jq-3.6.0/dt-1.13.4/datatables.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>




</head>
<body style="background-color:#10ba99;">


<jsp:include page="../components/Navbar.jsp"></jsp:include>
<main class="articulosBody d-flex justify-content-center align-items-center flex-column w-100">
	<section class="sectionTable">
	<div class="row justify-content-around">
		<h2>Articulos</h2>
		<p>${Mensaje}</p>
	</div>
	
	<!-- Action Modal -->
	<button type="button" class="btnNewArt " data-bs-toggle="modal" data-bs-target="#newArt">
  		Nuevo Articulo
	</button>
	
	
	<!-- INICIO DATATABLE -->
	<table id="tableArticulos" class="responsive table table-striped dataTables_wraper">
		<thead>
			<tr>
				<th style="display:none">ID</th>
				<th>Nombre</th>
				<th>Descripcion</th>
				<th>Marca</th>
				<th>Tipo</th>
				<th>Precio</th>
				<th>Acciones</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${articulos}" var="item">
				<tr>
					<td style="display:none">${item.id}</label> </td>
					<td>${item.nombre}</label> </td>
					<td>${item.descripcion}</td>
					<td>${item.marca.nombre}</td>
					<td>${item.tipo.descripcion}</td>
					<td>${item.precio}</td>
					<td>
						<button class="btnNewArt" onclick='editOpen(${item.id})'>
							<i class="fa-solid fa-pencil"></i>
						</button>
						<button class="btnCancel" onclick='confirmDelete(${item.id})'>
							<i class="fa-solid fa-trash"></i>
						</button>
					</td>
				</tr>
			</c:forEach>
	    </tbody>
	</table>
	</section>
	<!-- END DATATABLE -->
	
	<!-- MODALS -->
	<!-- Modal NUEVO ARTICULO -->
		<div class="modal fade" id="newArt" tabindex="-1" aria-labelledby="newArtlabel" aria-hidden="true">
  			<div class="modal-dialog modal-lg">
    			<div class="modal-content">
      				<div class="modal-header" style="background: #DAAE59; color: #fff;">
        				<h5 class="modal-title" id="newArtlabel">Nuevo Articulo</h5>
        				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      				</div>
      				<div class="modal-body">
      					<form action="${pageContext.request.contextPath}/articulos/crear" method="POST">
      						<input type="hidden" id="estado" value="true" name="estado">
      						<div class="col-md-12">
      							<label class="form-label">Nombre</label>
      							<input id="nombre" type="text" name="nombre" class="form-control" required>
      						</div>
      						<div class="row">
      							<div class="col-md-6">
      								<label class="form-label">Descripcion</label>
      								<input id="descripcion" type="text" name="descripcion" class="form-control" required>
      							</div>
      							<div class="col-md-6">
      								<label class="form-label">Marca</label>
      								<select id="marca" name="marca" class="form-control">
   							 			<c:forEach items="${listaMarcas}" var="item">
      										<option value="${item.idmarca}">${item.nombre}</option>
   								 		</c:forEach>
  									</select>
      							</div>
      						</div>
      						<div class="row">
	      						<div class="col-md-6">
	      							<label class="form-label">Tipo Articulos</label>
	      							<select id="tipo" name="tipo" class="form-control">
   							 			<c:forEach items="${tipoArticulos}" var="item">
      										<option value="${item.idtipo}">${item.descripcion}</option>
   								 		</c:forEach>
  									</select>
	      						</div>
	      						<div class="col-md-6">
	      							<label class="form-label">Precio</label>
	      							<input id="precio" type="number" min="0" name="precio" class="form-control" required>
	      						</div>
      						</div>
      						<div class="mt-5">
		        				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
		        				<button type="submit" class="btn " style="background: #DAAE59; color: #fff;">Ingresar Articulo</button>
							</div>
      					</form>
    			</div>
  			</div>
		</div>
		</div>
		
		
		<!-- Modal EDITAR ARTICULO -->
		<div class="modal fade" id="editArt" tabindex="-1" aria-labelledby="editArtLabel" aria-hidden="true">
  			<div class="modal-dialog modal-lg">
    			<div class="modal-content">
      				<div class="modal-header">
        				<h5 class="modal-title" id="editArtLabel">Editar Articulo</h5>
        				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      				</div>
      				<div class="modal-body">
      					<form id="formEditar" action="${pageContext.request.contextPath}/articulos/editar" method="POST">
      						<input type="hidden" id="id" name="id">
      						
      						<!-- <input type="hidden" id="estado" value="true" name="estado">-->
      						
      						<div class="col-md-12">
      							<label class="form-label">Nombre</label>
      							<input id="nombreEdit" type="text" name="nombre" class="form-control" required>
      						</div>
      						<div class="row">
      							<div class="col-md-6">
      								<label class="form-label">Descripcion</label>
      								<input id="descripcionEdit" type="text" name="descripcion" class="form-control" required>
      							</div>
      							<div class="col-md-6">
      								<label class="form-label">Marca</label>
      								<select id="marcaEdit" name="marca" class="form-control">
   							 			<c:forEach items="${listaMarcas}" var="marca">
      										<option value="${marca.idmarca}">${marca.nombre}</option>
   								 		</c:forEach>
  									</select>
      							</div>
      						</div>
      						<div class="row">
	      						<div class="col-md-6">
	      							<label class="form-label">Tipo Articulos</label>
	      							<select id="tipoEdit" name="tipo" class="form-control">
   							 			<c:forEach items="${tipoArticulos}" var="item">
      										<option value="${item.idtipo}">${item.descripcion}</option>
   								 		</c:forEach>
  									</select>
	      						</div>
	      						<div class="col-md-6">
	      							<label class="form-label">Precio</label>
	      							<input id="precioEdit" type="number" min="0" name="precio" class="form-control" required>
	      						</div>
      						</div>
      						<div class="mt-5">
		        				<button type="button" class="btn btnCancel" data-bs-dismiss="modal">Cancelar</button>
		        				<button type="submit" class="btn btnNewArt">Guardar</button>
							</div>
      					</form>
    			</div>
  			</div>
		</div>
		</div>
		
		<!-- Modal Borrar -->
		<div class="modal fade" id="deleteArt" tabindex="-1" aria-labelledby="deleteArtLabel" aria-hidden="true">
  			<div class="modal-dialog modal-lg">
    			<div class="modal-content">
      				<div class="modal-header" style="background: #B32D2D; color: #fff">
        				<h5 class="modal-title" id="deleteArtLabel">Borrar Articulo</h5>
        				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      				</div>
      				<div class="modal-body">
      					<form id="formDelete" action="${pageContext.request.contextPath}/articulos/eliminar" method="GET">
      						<!-- <input type="hidden" id="estado" value="true" name="estado">-->
      						<p style="font-weight: bold; font-size:20px;">Usted esta a punto de eliminar un articulo</p>
      						<p>¿Seguro desea realizar la operacion?</p>
      						<div class="mt-3">
      							<button class="btn btn-secondary">Cancel</button>
      							<button class="btn btn-danger" type="submit">OK</button>
      						</div>
      					</form>
    			</div>
  			</div>
		</div>
</main>	
<!-- SCRIPTS INIT -->
<script>
$(document).ready( function () {
	
	$.extend($.fn.dataTable.defaults, {
	    language: {
	      search: 'Buscar' ,
	      lengthMenu: 'Mostrar _MENU_ registros'
	    }
	  });
	
    $('#tableArticulos').DataTable({
        order: [[0, 'desc']] // Ordena por la primera columna (ID) de forma descendente
    });
    
  $('#newArt').on("submit", function(e){
        e.preventDefault();
        let action = e.target.getAttribute('action');
        let data = {
			nombre: $('#nombre').val(),
			descripcion: $('#descripcion').val(),
			marca: Number($('#marca').val()),
		    tipo: Number($('#tipo').val()),
			precio: $('#precio').val()
        }
		
        $.ajax({
            url: action +"/"+data.nombre+"/"+data.descripcion+"/"+data.marca+"/"+data.tipo+"/"+data.precio,
            method: "GET",
            data,
            success: function(data){
                console.log(data);
                let res = JSON.parse(data);

                if(res.status == 'ok'){
                    mostrarNotificacionYRecargar(res.message + ". Refrescando sitio...");
                }
                if(res.status == 'error'){
                	errorNotification(res.message)
                }

            },
            error: function(res, error) {
                console.log(res);
                console.log(error);
                errorNotification(res.message + ". Refrescando sitio...");
            }
        })
	});
    
    
    $('#formEditar').on("submit", function(e){
        e.preventDefault();
        let action = e.target.getAttribute('action');
        let data = {
            id: Number($('#id').val()),
			nombre: $('#nombreEdit').val(),
			descripcion: $('#descripcionEdit').val(),
			marca: $('#marcaEdit').val(),
		    tipo: $('#tipoEdit').val(),
			precio: $('#precioEdit').val()
        }

        $.ajax({
            url: action +"/"+data.id+"/"+data.nombre+"/"+data.descripcion+"/"+data.marca+"/"+data.tipo+"/"+data.precio,
            method: "GET",
            data,
            success: function(data){
                console.log(data);
                let res = JSON.parse(data);

                if(res.status == 'ok'){
                    mostrarNotificacionYRecargar(res.message + ". Refrescando sitio...");
                }
                if(res.status == 'error'){
                	errorNotification(res.message)
                }
            },
            error: function(res, error) {
                console.log(res);
                console.log(error);
                errorNotification(res.message + ". Refrescando sitio...");
            }
        })
	});
    
    $('#formDelete').on("submit", function(e){
        e.preventDefault();
        let action = e.target.getAttribute('action');

        $.ajax({
            url: action,
            method: "get",
            success: function(data){
                console.log(data);
                let res = JSON.parse(data);

					if(res.status == 'ok')
                    mostrarNotificacionYRecargar(res.message + ". Refrescando sitio...");
            },
            error: function(res, error) {
                console.log(res);
                console.log(error);
                errorNotification(res.message + ". Refrescando sitio...");
            }
        })
	});
    
});


function editOpen(id){
	$.ajax({
		url: "${pageContext.request.contextPath}/articulos/getArticulo/"+id,
		method: "GET",
		success: function(json){
			let res = JSON.parse(json);
			console.log(res);
			$('#id').val(res.id);
			$('#nombreEdit').val(res.nombre);
			$('#descripcionEdit').val(res.descripcion);
			$('#marcaEdit').val(res.marca.idmarca);
			$('#tipoEdit').val(res.tipo.idtipo);
			$('#precioEdit').val(res.precio);
		},
		complete: function() {
			$('#editArt').modal('toggle');
		}
		
	})
}


function confirmDelete(id){
	$('#formDelete').attr('action', '${pageContext.request.contextPath}/articulos/eliminar/'+id);
	$('#deleteArt').modal('toggle');
}

function mostrarNotificacionYRecargar(mensaje) {
    // Configura la notificación Toastr
    toastr.options = {
        closeButton: true,
        progressBar: true,
        positionClass: "toast-top-right",
        timeOut: 2000 // Duración de la notificación en milisegundos (3 segundos en este caso)
    };

    // Muestra la notificación Toastr
    toastr.success(mensaje, "Éxito", {
        onHidden: function () {
            // Recarga la página después de que se cierre la notificación
            window.location.reload();
        }
    });
}

function errorNotification(mensaje){
	toastr.options = {
	        closeButton: true,
	        progressBar: true,
	        positionClass: "toast-top-right",
	        timeOut: 2000 // Duración de la notificación en milisegundos (3 segundos en este caso)
	    };

	    // Muestra la notificación Toastr
	    toastr.error(mensaje, "Error", {
	    });
	
}
</script>
<c:if test="${not empty sessionScope.mensaje}">
    <%-- Configurar la notificación Toastr --%>
    <script>
    mostrarNotificacionYRecargar("${sessionScope.mensaje}")
    </script>

    <%-- Limpiar el mensaje de la sesión para que no se muestre nuevamente en futuras peticiones --%>
    <% session.removeAttribute("mensaje"); %>
</c:if>
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

</body>

</html>