<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Store project: admin page</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
	
	<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: 'bootstrap.js')}"></script>
	
    <!-- Le styles -->
    <style type="text/css">
      body {
        padding-top: 60px;
        padding-bottom: 40px;
      }
      .sidebar-nav {
        padding: 9px 0;
      }
    </style>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap.css')}" type="text/css">
    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

    <!-- Le fav and touch icons -->
    <link rel="shortcut icon" href="images/favicon.ico">
    <link rel="apple-touch-icon" href="images/apple-touch-icon.png">
    <link rel="apple-touch-icon" sizes="72x72" href="images/apple-touch-icon-72x72.png">
    <link rel="apple-touch-icon" sizes="114x114" href="images/apple-touch-icon-114x114.png">
  	
  	<script type="text/javascript" src="${resource(dir: 'js', file: 'showdown.js')}"></script>
  	
  	<g:layoutHead/>
  
  </head>

  <body>

    <div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container-fluid">
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
          <g:link class="brand" controller="exercices" action="index">Student cloud</g:link>
          <div class="nav-collapse">
            <ul class="nav">
            
            
              <li><g:link controller="exercices" action="index">Exercices</g:link></li>
              <li><g:link controller="administration" action="index">Administration</g:link></li>
            </ul>
            <p class="navbar-text pull-right">
            </p>
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>
	
    <div class="container-fluid">
      <div class="row-fluid">                 
          <g:layoutBody/>
      </div><!--/row-->

      <hr>

      <footer>
        <p>&copy; Company 2012</p>
      </footer>

    </div><!--/.fluid-container-->
    
    
	
	<r:layoutResources />
	
  </body>
</html>
