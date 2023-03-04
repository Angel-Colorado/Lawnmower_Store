<%--Name:        Angel Mario Colorado Chairez
Done for:        PROG1210 / Final Exam Hands-on Project
Last Modified:   December 16, 2022
Description:     » Develop a programming solution for the Emma’s Small Engine business case from PROG1180
                 » Use ADO, Datasets, and programming techniques from PROG1210 to implement the database
                    functionality of the new Emma’s Small Engine system--%>


<%@ Page Title="Orders" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Orders.aspx.cs" Inherits="WebFinal.Orders" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="alert alert-info" role="alert">
        <asp:Label ID="lblStatus" class="text-dark" Text="Ready..." runat="server"></asp:Label>
        <asp:ValidationSummary class="mt-2" ID="ValidationSummary1" runat="server" />
    </div>

    <div class="navbar navbar-light input-group" style="background-color: #e9ecef;">
        <asp:TextBox ID="ordRecSearch" class="form-control" placeholder="Search by Order#, Customer, Employee, Date or Payment type" aria-label="Search" aria-describedby="basic-addon2" runat="server"></asp:TextBox>
        <div class="input-group-append">
            <asp:Button ID="btnSearchOrd" class="btn btn-primary" runat="server" Text="Search" Style="left: 0px; top: 0px" />
            <asp:Button ID="btnSearchClr" class="btn btn-outline-secondary" runat="server" Text="Clear" OnClick="BtnSearchClr_Click" Style="left: 0px; top: 0px" />
        </div>
    </div>

    <br />
    <div class="container">
        <div class="row">
            <div class="col-md-8">
                <asp:GridView ID="gvOrderReceipts" class="table table-sm table-hover table-striped table-borderless" Style="border: none" runat="server" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="ObjectDataSource1" ShowHeaderWhenEmpty="True" AllowPaging="True" PageSize="8" OnSelectedIndexChanged="GvOrderReceipts_SelectedIndexChanged">
                    <Columns>
                        <asp:BoundField DataField="ordNumber" HeaderText="Order #" SortExpression="ordNumber">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="customerFull" HeaderText="Customer" SortExpression="customerFull" ReadOnly="True">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="employeeFull" HeaderText="Employee" SortExpression="employeeFull" ReadOnly="True">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ordDate" DataFormatString="{0:yyyy-MM-dd}" HeaderText="Date" SortExpression="ordDate">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="payType" HeaderText="Payment" SortExpression="payType">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:CheckBoxField DataField="ordPaid" HeaderText="Paid?" SortExpression="ordPaid">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:CheckBoxField>
                        <asp:TemplateField ShowHeader="False">
                            <HeaderTemplate>
                                <asp:Button ID="btnAddOrder" class="btn btn-success btn-sm" OnClick="BtnAddOrder_Click" runat="server" Text="Add Order" Style="left: 0px; top: 0px" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Button ID="btnSelectRcpt" class="btn btn-outline-info btn-sm" runat="server" CausesValidation="False" CommandName="Select" Text="Details"></asp:Button>
                            </ItemTemplate>
                            <HeaderStyle BackColor="White" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle CssClass="text-white bg-primary" HorizontalAlign="Center"></HeaderStyle>
                    <PagerStyle CssClass="pagination justify-content-center" />
                </asp:GridView>
            </div>
            <div class="col-md-4">
                <asp:FormView ID="fvOrderReceipt" runat="server" DataKeyNames="id" DataSourceID="ObjectDataSource2" OnItemDeleted="FvOrderReceipt_ItemDeleted" OnItemInserted="FvOrderReceipt_ItemInserted" OnItemUpdated="FvOrderReceipt_ItemUpdated">
                    <EditItemTemplate>
                        <div class="card card-body" style="background-color: #e9ecef;">
                            <dl class="row">
                                <h5 class="col-md-12 text-center font-weight-bold">Edit Order</h5>
                                <dt class="col-md-4">
                                    <label style="margin-bottom: 1rem">ID:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:Label ID="idLabel" runat="server" Text='<%# Eval("id") %>' />
                                </dd>
                                <dt class="col-md-4">
                                    <label>Order #:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:TextBox ID="ordNumberEdit" class="form-control" runat="server" Text='<%# Bind("ordNumber") %>' />
                                    <asp:RegularExpressionValidator ControlToValidate="ordNumberEdit" ValidationExpression="^.{0,20}$" ErrorMessage="<span class='text-danger'><strong>F. Name:</strong> Enter a 20 chars MAX string</span>" style="display: none" runat="server"></asp:RegularExpressionValidator>
                                </dd>
                                <dt class="col-md-4">
                                    <label>Customer:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:DropDownList ID="ddlCustEdit" class="form-control" runat="server" Text='<%# Bind("custID") %>' DataSourceID="ObjectDataSource3" DataTextField="custFull" DataValueField="id"></asp:DropDownList>
                                </dd>
                                <dt class="col-md-4">
                                    <label>Employee:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:DropDownList ID="ddlEmpEdit" class="form-control" runat="server" Text='<%# Bind("empID") %>' DataSourceID="ObjectDataSource4" DataTextField="empFull" DataValueField="id"></asp:DropDownList>
                                </dd>
                                <dt class="col-md-4">
                                    <label>Date:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:TextBox ID="ordDateEdit" class="form-control" placeholder="yyyy-mm-dd" runat="server" Text='<%# Bind("ordDate", "{0:yyyy-MM-dd}") %>' />
                                    <asp:RangeValidator ControlToValidate="ordDateEdit" MinimumValue="2000-01-01" MaximumValue="2100-12-31" Type="Date" ErrorMessage="<span class='text-danger'><strong>Date:</strong> The date must be between the years '2000' and '2100' with the format 'yyyy-mm-dd'</span>" style="display: none" runat="server"></asp:RangeValidator>
                                </dd>
                                <dt class="col-md-4">
                                    <label>Payment:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:DropDownList ID="ddlPayEdit" class="form-control" runat="server" Text='<%# Bind("paymentID") %>' DataSourceID="ObjectDataSource5" DataTextField="payType" DataValueField="id"></asp:DropDownList>
                                </dd>
                                <dt class="col-md-4">
                                    <label>Paid?:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:CheckBox ID="ordPaidCheckBox" runat="server" Checked='<%# Bind("ordPaid") %>' />
                                </dd>
                            </dl>
                            <div class="d-flex justify-content-around col-md-8 offset-md-2">
                                <br />
                                <asp:Button ID="Button3" class="btn btn-outline-primary btn-sm" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                                &nbsp;<asp:Button ID="Button4" class="btn btn-outline-dark btn-sm" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                            </div>
                        </div>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <div class="card card-body" style="background-color: #e9ecef;">
                            <dl class="row">
                                <h5 class="col-md-12 text-center font-weight-bold">Add Order</h5>
                                <dt class="col-md-4">
                                    <label>Order #:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:TextBox ID="ordNumberInsert" class="form-control" runat="server" Text='<%# Bind("ordNumber") %>' />
                                    <asp:RegularExpressionValidator ControlToValidate="ordNumberInsert" ValidationExpression="^.{0,20}$" ErrorMessage="<span class='text-danger'><strong>F. Name:</strong> Enter a 20 chars MAX string</span>" style="display: none" runat="server"></asp:RegularExpressionValidator>
                                </dd>
                                <dt class="col-md-4">
                                    <label>Customer:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:DropDownList ID="ddlCustIns" class="form-control" runat="server" Text='<%# Bind("custID") %>' DataSourceID="ObjectDataSource3" DataTextField="custFull" DataValueField="id"></asp:DropDownList>
                                </dd>
                                <dt class="col-md-4">
                                    <label>Employee:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:DropDownList ID="ddlEmpIns" class="form-control" runat="server" Text='<%# Bind("empID") %>' DataSourceID="ObjectDataSource4" DataTextField="empFull" DataValueField="id"></asp:DropDownList>
                                </dd>
                                <dt class="col-md-4">
                                    <label>Date:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:TextBox ID="ordDateInsert" class="form-control" placeholder="yyyy-mm-dd" runat="server" Text='<%# Bind("ordDate", "{0:yyyy-MM-dd}") %>' />
                                    <asp:RangeValidator ControlToValidate="ordDateInsert" MinimumValue="2000-01-01" MaximumValue="2100-12-31" Type="Date" ErrorMessage="<span class='text-danger'><strong>Date:</strong> The date must be between the years '2000' and '2100' with the format 'yyyy-mm-dd'</span>" style="display: none" runat="server"></asp:RangeValidator>
                                </dd>
                                <dt class="col-md-4">
                                    <label>Payment:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:DropDownList ID="ddlPayIns" class="form-control" runat="server" Text='<%# Bind("paymentID") %>' DataSourceID="ObjectDataSource5" DataTextField="payType" DataValueField="id"></asp:DropDownList>
                                </dd>
                                <dt class="col-md-4">
                                    <label>Paid?:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("ordPaid") %>' />
                                </dd>
                            </dl>
                            <div class="d-flex justify-content-around col-md-8 offset-md-2">
                                <br />
                                <asp:Button ID="InsertButton" class="btn btn-outline-success btn-sm" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                                &nbsp;<asp:Button ID="InsertCancelButton" class="btn btn-outline-dark btn-sm" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                            </div>
                        </div>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <div class="card card-body" style="background-color: #e9ecef;">
                            <dl class="row">
                                <h5 class="col-md-12 text-center font-weight-bold">Order Details</h5>
                                <dt class="col-md-4">
                                    <label>ID:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:Label ID="idLabel" runat="server" Text='<%# Eval("id") %>' />
                                </dd>
                                <dt class="col-md-4">
                                    <label>Order #:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:Label ID="ordNumberLabel" runat="server" Text='<%# Bind("ordNumber") %>' />
                                </dd>
                                <dt class="col-md-4">
                                    <label>Customer:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:DropDownList ID="ddlCustIt" runat="server" Text='<%# Bind("custID") %>' DataSourceID="ObjectDataSource3" DataTextField="custFull" DataValueField="id" TabIndex="-1" Style="appearance: none; border: none; background: none; pointer-events: none; color: #212529" AutoPostBack="True"></asp:DropDownList>
                                </dd>
                                <dt class="col-md-4">
                                    <label>Employee:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:DropDownList ID="ddlEmpIt" runat="server" Text='<%# Bind("empID") %>' DataSourceID="ObjectDataSource4" DataTextField="empFull" DataValueField="id" TabIndex="-1" Style="appearance: none; border: none; background: none; pointer-events: none; color: #212529" AutoPostBack="True"></asp:DropDownList>
                                </dd>
                                <dt class="col-md-4">
                                    <label>Date:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:Label ID="ordDateLabel" runat="server" Text='<%# Bind("ordDate", "{0:yyyy-MMM-dd}") %>' />
                                </dd>
                                <dt class="col-md-4">
                                    <label>Payment:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:DropDownList ID="ddlPayIt" runat="server" Text='<%# Bind("paymentID") %>' DataSourceID="ObjectDataSource5" DataTextField="payType" DataValueField="id" TabIndex="-1" Style="appearance: none; border: none; background: none; pointer-events: none; color: #212529" AutoPostBack="True"></asp:DropDownList>
                                </dd>
                                <dt class="col-md-4">
                                    <label>Paid?:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:CheckBox ID="ordPaidCheckBox" runat="server" Checked='<%# Bind("ordPaid") %>' Enabled="false" />
                                </dd>
                            </dl>
                            <div class="d-flex justify-content-around col-md-8 offset-md-2">
                                <asp:Button ID="Button1" class="btn btn-outline-primary btn-sm" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                                &nbsp;<asp:Button ID="Button2" class="btn btn-outline-danger btn-sm" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this record?')" />
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
                <asp:GridView ID="gvProducts" class="table table-sm table-hover table-striped table-borderless" Style="border: none" runat="server" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="ObjectDataSource6" AllowPaging="True" PageSize="8" EnableViewState="False" ShowFooter="True" EmptyDataText="<h5 style='background-color: #FEBE8C;' class='alert'>No Inventory_Products found</h5>" ShowHeaderWhenEmpty="True">
                    <Columns>
                        <asp:BoundField DataField="prodName" HeaderText="Product" SortExpression="prodName" />
                        <asp:BoundField DataField="invSize" HeaderText="Size" SortExpression="invSize" DataFormatString="{0:0.###}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="invMeasure" HeaderText="Units" SortExpression="invMeasure">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="orlQuantity" HeaderText="Qty" SortExpression="orlQuantity" DataFormatString="{0:n0}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Price" SortExpression="orlPrice">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("orlPrice") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("orlPrice", "{0:c}") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label CssClass="font-weight-bolder" runat="server" Text="Total:" ></asp:Label></>
                            </FooterTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                            <FooterStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Total" SortExpression="lineTotal">
                            <EditItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("lineTotal", "{0:c}") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("lineTotal", "{0:c}") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="sumTotal" CssClass="font-weight-bolder text-primary" runat="server" Text='<%# this.sumTotals.ToString("c") %>'></asp:Label></>
                            </FooterTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                            <FooterStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:CheckBoxField DataField="orlOrderReq" HeaderText="OrderReq" SortExpression="orlOrderReq">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:CheckBoxField>
                        <asp:TemplateField ShowHeader="False">
                            <HeaderTemplate>
                                <asp:Button ID="btnAddLine" class="btn btn-success btn-sm" OnClick="BtnAddLine_Click" runat="server" Text="Add OrderLine" Style="left: 0px; top: 0px"/>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Button ID="btnSelect" class="btn btn-outline-info btn-sm" runat="server" CausesValidation="False" CommandName="Select" Text="Details"></asp:Button>
                            </ItemTemplate>
                            <HeaderStyle BackColor="White" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataRowStyle CssClass="bg-transparent" HorizontalAlign="Center" />
                    <FooterStyle CssClass="bg-transparent"/>
                    <HeaderStyle CssClass="text-white bg-primary" HorizontalAlign="Center"></HeaderStyle>
                    <PagerStyle CssClass="pagination justify-content-center" />
                </asp:GridView>
            </div>
            <div class="col-md-4">
                <asp:FormView ID="fvOrderLine" runat="server" DataKeyNames="id" DataSourceID="ObjectDataSource7" OnItemDeleted="FvOrderLine_ItemDeleted" OnItemInserted="FvOrderLine_ItemInserted" OnItemUpdated="FvOrderLine_ItemUpdated" >
                    <EditItemTemplate>
                        <div class="card card-body" style="background-color: #e9ecef;">
                            <dl class="row">
                                <h5 class="col-md-12 text-center font-weight-bold">Edit Order Line</h5>
                                <dt class="col-md-4">
                                    <label style="margin-bottom: 1rem">ID:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:Label ID="idLabel" runat="server" Text='<%# Eval("id") %>' />
                                </dd>
                                <dt class="col-md-4">
                                    <label>Qty:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:TextBox ID="orlQuantityEdit" class="form-control" runat="server" Text='<%# Bind("orlQuantity") %>' />
                                    <asp:RangeValidator ControlToValidate="orlQuantityEdit" MinimumValue="0" MaximumValue="2147483647" Type="Integer" ErrorMessage="<span class='text-danger'><strong>Qty:</strong> The value must be between '0' and '2147483647'</span>" style="display: none" runat="server"></asp:RangeValidator>
                                </dd>
                                <dt class="col-md-4">
                                    <label>Price:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:TextBox ID="orlPriceEdit" class="form-control" placeholder="Eg. 3.12" runat="server" Text='<%# Bind("orlPrice") %>' />
                                    <asp:RangeValidator ControlToValidate="orlPriceEdit" MinimumValue="0" MaximumValue="922337203685477.00" Type="Double" ErrorMessage="<span class='text-danger'><strong>Price:</strong> The value must be between '0' and '922337203685477.00'</span>" style="display: none" runat="server"></asp:RangeValidator>
                                </dd>
                                <dt class="col-md-4">
                                    <label>OrderReq:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:CheckBox ID="checkBox2" runat="server" Checked='<%# Bind("orlOrderReq") %>' />
                                </dd>
                                <dt class="col-md-4">
                                    <label>Inventory:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:DropDownList ID="ddlInvString" class="form-control" runat="server" Text='<%# Bind("inventoryID") %>' DataSourceID="ObjectDataSource8" DataTextField="inventoryString" DataValueField="id"></asp:DropDownList>
                                </dd>
                                <dt class="col-md-4">
                                    <label>Order:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:DropDownList ID="ddlRecString" class="form-control" runat="server" Text='<%# Bind("receiptID") %>' DataSourceID="ObjectDataSource9" DataTextField="receiptString" DataValueField="id"></asp:DropDownList>
                                </dd>
                                <dt class="col-md-4">
                                    <label>Notes:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:TextBox ID="orlNoteEdit" class="form-control" runat="server" Text='<%# Bind("orlNote") %>' />
                                    <asp:RegularExpressionValidator ControlToValidate="orlNoteEdit" ValidationExpression="^.{0,100}$" ErrorMessage="<span class='text-danger'><strong>Notes:</strong> Enter a 100 chars MAX string</span>" style="display: none" runat="server"></asp:RegularExpressionValidator>
                                </dd>
                            </dl>
                            <div class="d-flex justify-content-around col-md-8 offset-md-2">
                                <br />
                                <asp:Button ID="Button3" class="btn btn-outline-primary btn-sm" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                                &nbsp;<asp:Button ID="Button4" class="btn btn-outline-dark btn-sm" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                            </div>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <div class="card card-body" style="background-color: #e9ecef;">
                            <dl class="row">
                                <h5 class="col-md-12 text-center font-weight-bold">Add Order Line</h5>
                                <dt class="col-md-4">
                                    <label>Qty:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:TextBox ID="orlQuantityInsert" class="form-control" runat="server" Text='<%# Bind("orlQuantity") %>' />
                                    <asp:RangeValidator ControlToValidate="orlQuantityInsert" MinimumValue="0" MaximumValue="2147483647" Type="Integer" ErrorMessage="<span class='text-danger'><strong>Qty:</strong> The value must be between '0' and '2147483647'</span>" style="display: none" runat="server"></asp:RangeValidator>
                                </dd>
                                <dt class="col-md-4">
                                    <label>Price:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:TextBox ID="orlPriceInsert" class="form-control" placeholder="Eg. 3.12" runat="server" Text='<%# Bind("orlPrice") %>' />
                                    <asp:RangeValidator ControlToValidate="orlPriceInsert" MinimumValue="0" MaximumValue="922337203685477.00" Type="Double" ErrorMessage="<span class='text-danger'><strong>Price:</strong> The value must be between '0' and '922337203685477.00'</span>" style="display: none" runat="server"></asp:RangeValidator>
                                </dd>
                                <dt class="col-md-4">
                                    <label>OrderReq:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:CheckBox ID="checkBox2" runat="server" Checked='<%# Bind("orlOrderReq") %>' />
                                </dd>
                                <dt class="col-md-4">
                                    <label>Inventory:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:DropDownList ID="ddlInvString" class="form-control" runat="server" Text='<%# Bind("inventoryID") %>' DataSourceID="ObjectDataSource8" DataTextField="inventoryString" DataValueField="id"></asp:DropDownList>
                                </dd>
                                <dt class="col-md-4">
                                    <label>Order:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:DropDownList ID="ddlRecStringInsert" runat="server" Text='<%# Bind("receiptID") %>' DataSourceID="ObjectDataSource10" DataTextField="receiptString" DataValueField="id" TabIndex="-1" Style="appearance: none; border: none; background: none; pointer-events: none; color: #212529" AutoPostBack="True"></asp:DropDownList>
                                </dd>
                                <dt class="col-md-4">
                                    <label>Notes:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:TextBox ID="orlNoteInsert" class="form-control" runat="server" Text='<%# Bind("orlNote") %>' />
                                    <asp:RegularExpressionValidator ControlToValidate="orlNoteInsert" ValidationExpression="^.{0,100}$" ErrorMessage="<span class='text-danger'><strong>Notes:</strong> Enter a 100 chars MAX string</span>" style="display: none" runat="server"></asp:RegularExpressionValidator>
                                </dd>
                            </dl>
                            <div class="d-flex justify-content-around col-md-8 offset-md-2">
                                <br />
                                <asp:Button ID="InsertButton" class="btn btn-outline-success btn-sm" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                                &nbsp;<asp:Button ID="InsertCancelButton" class="btn btn-outline-dark btn-sm" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                            </div>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <div class="card card-body" style="background-color: #e9ecef;">
                            <dl class="row">
                                <h5 class="col-md-12 text-center font-weight-bold">Order Line Details</h5>
                                <dt class="col-md-4">
                                    <label>ID:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("id") %>' />
                                </dd>
                                <dt class="col-md-4">
                                    <label>Qty:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:Label ID="orlQuantityLabel" runat="server" Text='<%# Bind("orlQuantity", "{0:n0}") %>' />
                                </dd>
                                <dt class="col-md-4">
                                    <label>Price:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:Label ID="orlPriceLabel" runat="server" Text='<%# Bind("orlPrice", "{0:c}") %>' />
                                </dd>
                                <dt class="col-md-4">
                                    <label>OrderReq:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:CheckBox ID="orlOrderReqCheckBox" runat="server" Checked='<%# Bind("orlOrderReq") %>' Enabled="false" />
                                </dd>
                                <dt class="col-md-4">
                                    <label>Inventory:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:DropDownList ID="ddlInvString" runat="server" Text='<%# Bind("inventoryID") %>' DataSourceID="ObjectDataSource8" DataTextField="inventoryString" DataValueField="id" TabIndex="-1" Style="appearance: none; border: none; background: none; pointer-events: none; color: #212529" AutoPostBack="True"></asp:DropDownList>
                                </dd>
                                <dt class="col-md-4">
                                    <label>Order:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:DropDownList ID="ddlRecStringItem" runat="server" Text='<%# Bind("receiptID") %>' DataSourceID="ObjectDataSource9" DataTextField="receiptString" DataValueField="id" TabIndex="-1" Style="appearance: none; border: none; background: none; pointer-events: none; color: #212529" AutoPostBack="True"></asp:DropDownList>
                                </dd>
                                <dt class="col-md-4">
                                    <label>Notes:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:Label ID="orlNoteLabel" TextMode="MultiLine" runat="server" Text='<%# Bind("orlNote") %>' />
                                </dd>
                            </dl>
                            <div class="d-flex justify-content-around col-md-8 offset-md-2">
                                <asp:Button ID="Button1" class="btn btn-outline-primary btn-sm" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                                &nbsp;<asp:Button ID="Button2" class="btn btn-outline-danger btn-sm" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this record?')" />
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:FormView>
            </div>
        </div>
    </div>

    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="LibraryFinal.EmmasDataSetTableAdapters.OrderReceiptTableAdapter" OnSelected="ObjectDataSource1_Selected">
        <SelectParameters>
            <asp:ControlParameter ControlID="ordRecSearch" Name="ordRecSearch" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="LibraryFinal.EmmasDataSetTableAdapters.OrderReceiptCRUDTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
        <DeleteParameters>
            <asp:Parameter Name="Original_id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ordNumber" Type="String" />
            <asp:Parameter Name="ordDate" Type="DateTime" />
            <asp:Parameter Name="ordPaid" Type="Boolean" />
            <asp:Parameter Name="paymentID" Type="Int32" />
            <asp:Parameter Name="custID" Type="Int32" />
            <asp:Parameter Name="empID" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="gvOrderReceipts" Name="Param1" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="ordNumber" Type="String" />
            <asp:Parameter Name="ordDate" Type="DateTime" />
            <asp:Parameter Name="ordPaid" Type="Boolean" />
            <asp:Parameter Name="paymentID" Type="Int32" />
            <asp:Parameter Name="custID" Type="Int32" />
            <asp:Parameter Name="empID" Type="Int32" />
            <asp:Parameter Name="Original_id" Type="Int32" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="LibraryFinal.EmmasDataSetTableAdapters.CustFullTableAdapter"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource4" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="LibraryFinal.EmmasDataSetTableAdapters.EmpFullTableAdapter"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource5" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="LibraryFinal.EmmasDataSetTableAdapters.PaymentTableAdapter"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource6" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="LibraryFinal.EmmasDataSetTableAdapters.OrderDetailsTableAdapter" OnSelected="ObjectDataSource6_Selected">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvOrderReceipts" Name="Param1" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource7" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="LibraryFinal.EmmasDataSetTableAdapters.OrderDetailsCRUDTableAdapter" UpdateMethod="Update">
        <DeleteParameters>
            <asp:Parameter Name="Original_id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="orlPrice" Type="Decimal" />
            <asp:Parameter Name="orlQuantity" Type="Int32" />
            <asp:Parameter Name="orlOrderReq" Type="Boolean" />
            <asp:Parameter Name="orlNote" Type="String" />
            <asp:Parameter Name="inventoryID" Type="Int32" />
            <asp:Parameter Name="receiptID" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="gvProducts" Name="Param1" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="orlPrice" Type="Decimal" />
            <asp:Parameter Name="orlQuantity" Type="Int32" />
            <asp:Parameter Name="orlOrderReq" Type="Boolean" />
            <asp:Parameter Name="orlNote" Type="String" />
            <asp:Parameter Name="inventoryID" Type="Int32" />
            <asp:Parameter Name="receiptID" Type="Int32" />
            <asp:Parameter Name="Original_id" Type="Int32" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource8" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="LibraryFinal.EmmasDataSetTableAdapters.InventoryStringTableAdapter"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource9" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="LibraryFinal.EmmasDataSetTableAdapters.OrderDetailsStringTableAdapter"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource10" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="LibraryFinal.EmmasDataSetTableAdapters.OrderDetailsStringInsertTableAdapter">
        <SelectParameters>
            <asp:ControlParameter ControlID="fvOrderReceipt" Name="Param1" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
