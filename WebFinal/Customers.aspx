<%--Name:        Angel Mario Colorado Chairez
Done for:        PROG1210 / Final Exam Hands-on Project
Last Modified:   December 16, 2022
Description:     » Develop a programming solution for the Emma’s Small Engine business case from PROG1180
                 » Use ADO, Datasets, and programming techniques from PROG1210 to implement the database
                    functionality of the new Emma’s Small Engine system--%>


<%@ Page Title="Customers" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Customers.aspx.cs" Inherits="WebFinal.Customers" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="alert alert-info" role="alert">
        <asp:Label ID="lblStatus" class="text-dark" Text="Ready..." runat="server"></asp:Label>
        <asp:ValidationSummary class="mt-2" ID="ValidationSummary1" runat="server" />
    </div>

    <div class="navbar navbar-light input-group" style="background-color: #e9ecef;">
        <asp:TextBox ID="custSearch" class="form-control" placeholder="Search by Full Name, Phone, City, Postal C. or E-mail" aria-label="Search" aria-describedby="basic-addon2" runat="server"></asp:TextBox>
        <div class="input-group-append">
            <asp:Button ID="btnSearchCust" class="btn btn-primary" runat="server" Text="Search" Style="left: 0px; top: 0px" />
            <asp:Button ID="btnSearchClr" class="btn btn-outline-secondary" runat="server" Text="Clear" OnClick="BtnSearchClr_Click" Style="left: 0px; top: 0px" />
        </div>
    </div>

    <br />
    <div class="container">
        <div class="row">
            <div class="col-md-8">
                <asp:GridView ID="gvCustomers" class="table table-sm table-hover table-striped table-borderless" Style="border: none" runat="server" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="ObjectDataSource1" ShowHeaderWhenEmpty="True" AllowPaging="True" PageSize="8">
                    <Columns>
                        <asp:BoundField DataField="custFullName" HeaderText="Full Name" SortExpression="custFullName" ReadOnly="True" />
                        <asp:BoundField DataField="custPhone" HeaderText="Phone" SortExpression="custPhone" DataFormatString="<a href=tel:+1{0}>{0}</a>" HtmlEncodeFormatString="false">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="custCity" HeaderText="City" SortExpression="custCity">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="custPostal" HeaderText="Postal C." SortExpression="custPostal">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="custEmail" HeaderText="E-mail" SortExpression="custEmail" DataFormatString="<a href=mailto:{0}>{0}</a>" HtmlEncodeFormatString="false">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:TemplateField ShowHeader="False">
                            <HeaderTemplate>
                                <asp:Button ID="btnAddCustomer" class="btn btn-success btn-sm" OnClick="BtnAddCustomer_Click" runat="server" Text="Add Customer" Style="left: 0px; top: 0px" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Button ID="btnSelect" class="btn btn-outline-info btn-sm" runat="server" CausesValidation="False" CommandName="Select" Text="Details"></asp:Button>
                            </ItemTemplate>
                            <HeaderStyle BackColor="White" />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle CssClass="text-white bg-primary" HorizontalAlign="Center"></HeaderStyle>
                    <PagerStyle CssClass="pagination justify-content-center" />
                </asp:GridView>
            </div>

            <div class="col-md-4">
                <asp:FormView ID="fvCustomer" runat="server" DataSourceID="ObjectDataSource2" DataKeyNames="id" OnItemUpdated="FvCustomer_ItemUpdated" OnItemInserted="FvCustomer_ItemInserted">
                    <EditItemTemplate>
                        <div class="card card-body" style="background-color: #e9ecef;">
                            <dl class="row">
                                <h5 class="col-md-12 text-center font-weight-bold">Edit Customer</h5>
                                <dt class="col-md-4">
                                    <label style="margin-bottom: 1rem">ID:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:Label ID="idLabel" runat="server" Text='<%# Eval("id") %>' />
                                </dd>
                                <dt class="col-md-4">
                                    <label>F. Name:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:TextBox ID="custFNameEdit" class="form-control" runat="server" Text='<%# Bind("custFirst") %>' />
                                    <asp:RegularExpressionValidator ControlToValidate="custFNameEdit" ValidationExpression="^.{0,30}$" ErrorMessage="<span class='text-danger'><strong>F. Name:</strong> Enter a 30 chars MAX string</span>" style="display: none" runat="server"></asp:RegularExpressionValidator>
                                </dd>
                                <dt class="col-md-4">
                                    <label>L. Name:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:TextBox ID="custLastTextBox" class="form-control" runat="server" Text='<%# Bind("custLast") %>' />
                                    <asp:RegularExpressionValidator ControlToValidate="custLastTextBox" ValidationExpression="^.{0,50}$" ErrorMessage="<span class='text-danger'><strong>L. Name:</strong> Enter a 50 chars MAX string</span>" style="display: none" runat="server"></asp:RegularExpressionValidator>
                                </dd>
                                <dt class="col-md-4">
                                    <label>Phone:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:TextBox ID="custPhoneTextBox" class="form-control" placeholder="10-digits" runat="server" Text='<%# Bind("custPhone") %>' />
                                    <asp:RegularExpressionValidator ControlToValidate="custPhoneTextBox" ValidationExpression="[0-9]{10}" ErrorMessage="<span class='text-danger'><strong>Phone:</strong> Enter a 10 digits phone number</span>" style="display: none" runat="server"></asp:RegularExpressionValidator>
                                </dd>
                                <dt class="col-md-4">
                                    <label>Address:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:TextBox ID="custAddressTextBox" class="form-control" runat="server" Text='<%# Bind("custAddress") %>' />
                                    <asp:RegularExpressionValidator ControlToValidate="custAddressTextBox" ValidationExpression="^.{0,60}$" ErrorMessage="<span class='text-danger'><strong>Address:</strong> Enter a 60 chars MAX string</span>" style="display: none" runat="server"></asp:RegularExpressionValidator>
                                </dd>
                                <dt class="col-md-4">
                                    <label>City:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:TextBox ID="custCityTextBox" class="form-control" runat="server" Text='<%# Bind("custCity") %>' />
                                    <asp:RegularExpressionValidator ControlToValidate="custCityTextBox" ValidationExpression="^.{0,50}$" ErrorMessage="<span class='text-danger'><strong>City:</strong> Enter a 50 chars MAX string</span>" style="display: none" runat="server"></asp:RegularExpressionValidator>
                                </dd>
                                <dt class="col-md-4">
                                    <label>Postal C.:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:TextBox ID="custPostalTextBox" class="form-control" placeholder="Eg. K1A0A4" runat="server" Text='<%# Bind("custPostal") %>' />
                                    <asp:RegularExpressionValidator ControlToValidate="custPostalTextBox" ValidationExpression="^[A-Z]\d[A-Z]\d[A-Z]\d$" ErrorMessage="<span class='text-danger'><strong>Postal C.:</strong> Enter a 6 characters (uppercase) Canadian Postal Code without spaces</span>" style="display: none" runat="server"></asp:RegularExpressionValidator>
                                </dd>
                                <dt class="col-md-4">
                                    <label>E-mail:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:TextBox ID="custEmailTextBox" placeholder="Eg. user@customer.ca" class="form-control" runat="server" Text='<%# Bind("custEmail") %>' />
                                    <asp:RegularExpressionValidator ControlToValidate="custEmailTextBox" ValidationExpression="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" ErrorMessage="<span class='text-danger'><strong>E-mail:</strong> Enter a valid e-mail address</span>" style="display: none" runat="server"></asp:RegularExpressionValidator>
                                </dd>
                            </dl>
                            <div class="d-flex justify-content-around col-md-8 offset-md-2">
                                <br />
                                <asp:Button ID="Button1" class="btn btn-outline-primary btn-sm" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                                &nbsp;<asp:Button ID="Button2" class="btn btn-outline-dark btn-sm" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                            </div>
                        </div>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <div class="card card-body" style="background-color: #e9ecef;">
                            <dl class="row">
                                <h5 class="col-md-12 text-center font-weight-bold">Add Customer</h5>
                                <dt class="col-md-4">
                                    <label>F. Name:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:TextBox ID="custFNameInsert" class="form-control" runat="server" Text='<%# Bind("custFirst") %>' />
                                    <asp:RegularExpressionValidator ControlToValidate="custFNameInsert" ValidationExpression="^.{0,30}$" ErrorMessage="<span class='text-danger'><strong>F. Name:</strong> Enter a 30 chars MAX string</span>" style="display: none" runat="server"></asp:RegularExpressionValidator>
                                </dd>
                                <dt class="col-md-4">
                                    <label>L. Name:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:TextBox ID="custLastInsert" class="form-control" runat="server" Text='<%# Bind("custLast") %>' />
                                    <asp:RegularExpressionValidator ControlToValidate="custLastInsert" ValidationExpression="^.{0,50}$" ErrorMessage="<span class='text-danger'><strong>L. Name:</strong> Enter a 50 chars MAX string</span>" style="display: none" runat="server"></asp:RegularExpressionValidator>
                                </dd>
                                <dt class="col-md-4">
                                    <label>Phone:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:TextBox ID="custPhoneInsert" class="form-control" placeholder="10-digits" runat="server" Text='<%# Bind("custPhone") %>' />
                                    <asp:RegularExpressionValidator ControlToValidate="custPhoneInsert" ValidationExpression="[0-9]{10}" ErrorMessage="<span class='text-danger'><strong>Phone:</strong> Enter a 10 digits phone number</span>" style="display: none" runat="server"></asp:RegularExpressionValidator>
                                </dd>
                                <dt class="col-md-4">
                                    <label>Address:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:TextBox ID="custAddressInsert" class="form-control" runat="server" Text='<%# Bind("custAddress") %>' />
                                    <asp:RegularExpressionValidator ControlToValidate="custAddressInsert" ValidationExpression="^.{0,60}$" ErrorMessage="<span class='text-danger'><strong>Address:</strong> Enter a 60 chars MAX string</span>" style="display: none" runat="server"></asp:RegularExpressionValidator>
                                </dd>
                                <dt class="col-md-4">
                                    <label>City:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:TextBox ID="custCityInsert" class="form-control" runat="server" Text='<%# Bind("custCity") %>' />
                                    <asp:RegularExpressionValidator ControlToValidate="custCityInsert" ValidationExpression="^.{0,50}$" ErrorMessage="<span class='text-danger'><strong>City:</strong> Enter a 50 chars MAX string</span>" style="display: none" runat="server"></asp:RegularExpressionValidator>
                                </dd>
                                <dt class="col-md-4">
                                    <label>Postal C.:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:TextBox ID="custPostalInsert" class="form-control" placeholder="Eg. K1A0A4" runat="server" Text='<%# Bind("custPostal") %>' />
                                    <asp:RegularExpressionValidator ControlToValidate="custPostalInsert" ValidationExpression="^[A-Z]\d[A-Z]\d[A-Z]\d$" ErrorMessage="<span class='text-danger'><strong>Postal C.:</strong> Enter a 6 characters (uppercase) Canadian Postal Code without spaces</span>" style="display: none" runat="server"></asp:RegularExpressionValidator>
                                </dd>
                                <dt class="col-md-4">
                                    <label>E-mail:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:TextBox ID="custEmailInsert" placeholder="Eg. user@customer.ca" class="form-control" runat="server" Text='<%# Bind("custEmail") %>' />
                                    <asp:RegularExpressionValidator ControlToValidate="custEmailInsert" ValidationExpression="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" ErrorMessage="<span class='text-danger'><strong>E-mail:</strong> Enter a valid e-mail address</span>" style="display: none" runat="server"></asp:RegularExpressionValidator>
                                </dd>
                            </dl>
                            <div class="d-flex justify-content-around col-md-8 offset-md-2">
                                <br />
                                <asp:Button ID="Button3" class="btn btn-outline-success btn-sm" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                                &nbsp;<asp:Button ID="Button4" class="btn btn-outline-dark btn-sm" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                            </div>
                        </div>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <div class="card card-body" style="background-color: #e9ecef;">
                            <dl class="row">
                                <h5 class="col-md-12 text-center font-weight-bold">Customer Details</h5>
                                <dt class="col-md-4">
                                    <label>ID:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:Label ID="idLabel" runat="server" Text='<%# Eval("id") %>' />
                                </dd>
                                <dt class="col-md-4">
                                    <label>F. Name:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:Label ID="custFirstLabel" runat="server" Text='<%# Bind("custFirst") %>' />
                                </dd>
                                <dt class="col-md-4">
                                    <label>L. Name:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:Label ID="custLastLabel" runat="server" Text='<%# Bind("custLast") %>' />
                                </dd>
                                <dt class="col-md-4">
                                    <label>Phone:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:Label ID="custPhoneLabel" runat="server" Text='<%# Bind("custPhone") %>' />
                                </dd>
                                <dt class="col-md-4">
                                    <label>Address:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:Label ID="custAddressLabel" runat="server" Text='<%# Bind("custAddress") %>' />
                                </dd>
                                <dt class="col-md-4">
                                    <label>City:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:Label ID="custCityLabel" runat="server" Text='<%# Bind("custCity") %>' />
                                </dd>
                                <dt class="col-md-4">
                                    <label>Postal C.:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:Label ID="custPostalLabel" runat="server" Text='<%# Bind("custPostal") %>' />
                                </dd>
                                <dt class="col-md-4">
                                    <label>E-mail:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:Label ID="custEmailLabel" runat="server" Text='<%# Bind("custEmail") %>' />
                                </dd>
                            </dl>
                            <div class="d-flex justify-content-around col-md-8 offset-md-2">
                                <asp:Button ID="EditButton" class="btn btn-outline-primary btn-sm" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:FormView>
            </div>
        </div>
    </div>


    <hr />
    <br />
    <div class="container">
        <div class="row">
            <div class="col-md-8">
                <asp:GridView ID="gvOrders" class="table table-sm table-hover table-striped table-borderless" Style="border: none" runat="server" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="ObjectDataSource4" AllowPaging="True" PageSize="8" EmptyDataText="<h5 style='background-color: #FEBE8C;' class='alert'>No Orders found</h5>" ShowHeaderWhenEmpty="True">
                    <Columns>
                        <asp:BoundField DataField="ordNumber" HeaderText="Order #" SortExpression="ordNumber" />
                        <asp:BoundField DataField="ordDate" DataFormatString="{0:yyyy-MM-dd}" HeaderText="Date" SortExpression="ordDate" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:CheckBoxField DataField="ordPaid" HeaderText="Paid?" SortExpression="ordPaid" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:CheckBoxField>
                        <asp:BoundField DataField="employeeFull" HeaderText="Employee" ReadOnly="True" SortExpression="employeeFull" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="payType" HeaderText="Payment" SortExpression="payType" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                    </Columns>
                    <EmptyDataRowStyle CssClass="bg-transparent" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="text-white bg-primary" HorizontalAlign="Center"></HeaderStyle>
                    <PagerStyle CssClass="pagination justify-content-center" />
                </asp:GridView>
            </div>
        </div>
    </div>

    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="LibraryFinal.EmmasDataSetTableAdapters.CustomerTableAdapter" OnSelected="ObjectDataSource1_Selected">
        <SelectParameters>
            <asp:ControlParameter ControlID="custSearch" Name="custSearch" PropertyName="Text" Type="String" DefaultValue="%" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="LibraryFinal.EmmasDataSetTableAdapters.CustomerCRUDTableAdapter" UpdateMethod="Update">
        <DeleteParameters>
            <asp:Parameter Name="Original_id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="custFirst" Type="String" />
            <asp:Parameter Name="custLast" Type="String" />
            <asp:Parameter Name="custPhone" Type="String" />
            <asp:Parameter Name="custAddress" Type="String" />
            <asp:Parameter Name="custCity" Type="String" />
            <asp:Parameter Name="custPostal" Type="String" />
            <asp:Parameter Name="custEmail" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="gvCustomers" Name="Param1" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="custFirst" Type="String" />
            <asp:Parameter Name="custLast" Type="String" />
            <asp:Parameter Name="custPhone" Type="String" />
            <asp:Parameter Name="custAddress" Type="String" />
            <asp:Parameter Name="custCity" Type="String" />
            <asp:Parameter Name="custPostal" Type="String" />
            <asp:Parameter Name="custEmail" Type="String" />
            <asp:Parameter Name="Original_id" Type="Int32" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="LibraryFinal.EmmasDataSetTableAdapters.OrderReceiptTableAdapter">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvCustomers" Name="ordRecSearch" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource4" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="LibraryFinal.EmmasDataSetTableAdapters.CustomerOrdersTableAdapter">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvCustomers" Name="Param1" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
