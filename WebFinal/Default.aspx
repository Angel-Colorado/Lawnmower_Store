<%--Name:        Angel Mario Colorado Chairez
Done for:        PROG1210 / Final Exam Hands-on Project
Last Modified:   December 16, 2022
Description:     » Develop a programming solution for the Emma’s Small Engine business case from PROG1180
                 » Use ADO, Datasets, and programming techniques from PROG1210 to implement the database
                    functionality of the new Emma’s Small Engine system--%>


<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebFinal._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <!--Fontawesome CDN-->
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">

	<!--Custom styles-->
	<link rel="stylesheet" type="text/css" href="Styles/login_styles.css">

    <div class="alert alert-info" role="alert">
        <asp:Label ID="lblStatus" class="text-dark" Text="Ready..." runat="server"></asp:Label>
        <asp:ValidationSummary class="mt-2" ID="ValidationSummary1" runat="server" />
    </div>
    <br /><br />

    <div class="container">
        <div class="d-flex justify-content-center h-100">
            <div class="card">
                <div class="card-header">
                    <h3 class="text-white">Sign In</h3>
                    <div class="d-flex justify-content-end social_icon">
                        <span><i class="fab fa-facebook-square"></i></span>
                        <span><i class="fab fa-google-plus-square"></i></span>
                        <span><i class="fab fa-twitter-square"></i></span>
                    </div>
                </div>
                <div class="card-body">
                        <div class="input-group form-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i class="fas fa-user"></i></span>
                            </div>
                            <asp:TextBox ID="txtUser" class="form-control" title="Enter your user name" required="true" placeholder="username" runat="server" />
                            <asp:RequiredFieldValidator ControlToValidate="txtUser" ErrorMessage="<strong>User name is required</strong>" style="display: none" runat="server" ></asp:RequiredFieldValidator>
                        </div>
                        <div class="input-group form-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i class="fas fa-key"></i></span>
                            </div>
                            <asp:TextBox ID="txtPass" class="form-control" placeholder="password" TextMode="password" runat="server" />
                            <asp:RequiredFieldValidator ControlToValidate="txtPass" ErrorMessage="<strong>Password is required</strong>" style="display: none" runat="server" ></asp:RequiredFieldValidator>
                        </div>
                        <div class="row align-items-center remember text-white" style="margin-bottom: 1rem">
                            <input type="checkbox">Remember Me
                        </div>
                        <div class="d-flex justify-content-end" style="margin-bottom: 2rem; margin-right: 1rem">
                            <asp:Button ID="btnLogin" class="btn btn-success" runat="server" Text="Login" OnClick="BtnLogin_Click" />
                        </div>
                    <div class="d-flex justify-content-center text-white">
                        Don't have an account?&nbsp<a style="color: #FF7501" href="#">Sign Up</a>
                    </div>
                    <div class="d-flex justify-content-center">
                        <a style="color: #FF7501" href="#">Forgot your password?</a>
                    </div>
                </div>
            </div>
        </div>
    </div>








</asp:Content>
