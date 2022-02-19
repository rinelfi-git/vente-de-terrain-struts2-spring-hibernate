<%--
  Created by IntelliJ IDEA.
  User: rinelfi
  Date: 05/12/2021
  Time: 16:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- /.content-header -->
<div class="container mb-2">
    <div class="card">
        <div class="card-body">
            <!-- SEARCH FORM -->
            <form>
                <div class="input-group input-group-lg">
                    <input class="form-control form-control-navbar" type="search" placeholder="Recherche" aria-label="Search">
                    <div class="input-group-append">
                        <button class="btn btn-primary" type="submit">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </div>
                <div class="btn-group mt-2">
                    <button class="btn btn-default mr-2 mb-2" data-toggle="modal" data-target="#element-per-page"><span class="material-icons">format_list_numbered</span></button>
                    <button class="btn btn-default mr-2 mb-2" data-toggle="modal" data-target="#module-recherche"><span class="material-icons">view_module</span></button>
                    <button class="btn btn-default mr-2 mb-2" data-toggle="modal" data-target="#tri"><span class="material-icons">sort</span></button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="element-per-page">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title">Default Modal</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>One fine body&hellip;</p>
      </div>
      <div class="modal-footer justify-content-between">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
    <!-- /.modal-content -->
  </div>
  <!-- /.modal-dialog -->
</div>