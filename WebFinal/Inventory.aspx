<%--Name:        Angel Mario Colorado Chairez
Done for:        PROG1210 / Final Exam Hands-on Project
Last Modified:   December 16, 2022
Description:     » Develop a programming solution for the Emma’s Small Engine business case from PROG1180
                 » Use ADO, Datasets, and programming techniques from PROG1210 to implement the database
                    functionality of the new Emma’s Small Engine system--%>


<%@ Page Title="Inventory" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Inventory.aspx.cs" Inherits="WebFinal.Inventory" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="alert alert-info" role="alert">
        <asp:Label ID="lblStatus" class="text-dark" Text="Ready..." runat="server"></asp:Label>
        <asp:ValidationSummary class="mt-2" ID="ValidationSummary1" runat="server" />
    </div>

    <div class="navbar navbar-light input-group" style="background-color: #e9ecef;">
        <asp:TextBox ID="invSearch" class="form-control" placeholder="Search by Product, Price greater than, Units or Brand" aria-label="Search" aria-describedby="basic-addon2" runat="server"></asp:TextBox>
        <div class="input-group-append">
            <asp:Button ID="btnSearchCust" class="btn btn-primary" runat="server" Text="Search" Style="left: 0px; top: 0px" />
            <asp:Button ID="btnSearchClr" class="btn btn-outline-secondary" runat="server" Text="Clear" Style="left: 0px; top: 0px" OnClick="BtnSearchClr_Click" />
        </div>
    </div>

    <br />
    <div class="container">
        <div class="row">
            <div class="col-md-8">
                <asp:GridView ID="gvInventory" class="table table-sm table-hover table-striped table-borderless" Style="border: none" runat="server" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="ObjectDataSource1" ShowHeaderWhenEmpty="True" AllowPaging="True" PageSize="8">
                    <Columns>
                        <asp:BoundField DataField="prodName" HeaderText="Product" SortExpression="prodName">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="invPrice" HeaderText="Price" SortExpression="invPrice" DataFormatString="{0:c}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="invQuantity" HeaderText="Qty" SortExpression="invQuantity">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="invSize" HeaderText="Size" SortExpression="invSize" DataFormatString="{0:0.###}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="invMeasure" HeaderText="Units" SortExpression="invMeasure">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="prodBrand" HeaderText="Brand" SortExpression="prodBrand">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:TemplateField ShowHeader="False">
                            <HeaderTemplate>
                                <asp:Button ID="btnAddInventory" class="btn btn-success btn-sm" OnClick="BtnAddInventory_Click" runat="server" Text="Add Inventory" Style="left: 0px; top: 0px" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Button ID="btnSelect" class="btn btn-outline-info btn-sm" runat="server" CausesValidation="False" CommandName="Select" Text="Details"></asp:Button>
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
                <asp:FormView ID="fvInventory" runat="server" DataKeyNames="id" DataSourceID="ObjectDataSource2" OnItemUpdated="FvInventory_ItemUpdated" OnItemDeleted="FvInventory_ItemDeleted" OnItemInserted="FvInventory_ItemInserted">
                    <EditItemTemplate>
                        <div class="card card-body" style="background-color: #e9ecef;">
                            <dl class="row">
                                <h5 class="col-md-12 text-center font-weight-bold">Edit Inventory</h5>
                                <dt class="col-md-4">
                                    <label style="margin-bottom: 1rem">ID:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:Label ID="idLabel" runat="server" Text='<%# Eval("id") %>' />
                                </dd>
                                <dt class="col-md-4">
                                    <label>Product:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:DropDownList ID="ddlProdEdit" class="form-control" runat="server" Text='<%# Bind("productID") %>' DataSourceID="ObjectDataSource3" DataTextField="prodName" DataValueField="id"></asp:DropDownList>
                                </dd>
                                <dt class="col-md-4">
                                    <label>Price:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:TextBox ID="invPriceEdit" class="form-control" placeholder="Eg. 3.12" runat="server" Text='<%# Bind("invPrice") %>' />
                                    <asp:RangeValidator ControlToValidate="invPriceEdit" MinimumValue="0" MaximumValue="922337203685477.00" Type="Double" ErrorMessage="<span class='text-danger'><strong>Price:</strong> The value must be between '0' and '922337203685477.00'</span>" style="display: none" runat="server"></asp:RangeValidator>
                                </dd>
                                <dt class="col-md-4">
                                    <label>Qty:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:TextBox ID="invQuantityEdit" class="form-control" runat="server" Text='<%# Bind("invQuantity") %>' />
                                    <asp:RangeValidator ControlToValidate="invQuantityEdit" MinimumValue="0" MaximumValue="2147483647" Type="Integer" ErrorMessage="<span class='text-danger'><strong>Qty:</strong> The value must be between '0' and '2147483647'</span>" style="display: none" runat="server"></asp:RangeValidator>
                                </dd>
                                <dt class="col-md-4">
                                    <label>Size:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:TextBox ID="invSizeEdit" class="form-control" placeholder="Eg. 3.12" runat="server" Text='<%# Bind("invSize") %>' />
                                    <asp:RangeValidator ControlToValidate="invSizeEdit" MinimumValue="0" MaximumValue="999.99" Type="Double" ErrorMessage="<span class='text-danger'><strong>Size:</strong> The value must be between '0' and '999.99'</span>" style="display: none" runat="server"></asp:RangeValidator>
                                </dd>
                                <dt class="col-md-4">
                                    <label>Units:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:TextBox ID="invMeasureEdit" class="form-control" runat="server" Text='<%# Bind("invMeasure") %>' />
                                    <asp:RegularExpressionValidator ControlToValidate="invMeasureEdit" ValidationExpression="^.{0,20}$" ErrorMessage="<span class='text-danger'><strong>Units:</strong> Enter a 20 chars MAX string</span>" style="display: none" runat="server"></asp:RegularExpressionValidator>
                                </dd>
                            </dl>
                            <div class="d-flex justify-content-around col-md-8 offset-md-2">
                                <br />
                                <asp:Button ID="UpdateButton" class="btn btn-outline-primary btn-sm" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                                &nbsp;<asp:Button ID="UpdateCancelButton" class="btn btn-outline-dark btn-sm" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                            </div>
                        </div>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <div class="card card-body" style="background-color: #e9ecef;">
                            <dl class="row">
                                <h5 class="col-md-12 text-center font-weight-bold" style="margin-bottom: 1rem">Add Inventory</h5>
                                <dt class="col-md-4">
                                    <label>Product:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:DropDownList ID="ddlProdInsert" class="form-control" runat="server" Text='<%# Bind("productID") %>' DataSourceID="ObjectDataSource3" DataTextField="prodName" DataValueField="id"></asp:DropDownList>
                                </dd>
                                <dt class="col-md-4">
                                    <label>Price:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:TextBox ID="invPriceInsert" class="form-control" placeholder="Eg. 3.12" runat="server" Text='<%# Bind("invPrice") %>' />
                                    <asp:RangeValidator ControlToValidate="invPriceInsert" MinimumValue="0" MaximumValue="922337203685477.00" Type="Double" ErrorMessage="<span class='text-danger'><strong>Price:</strong> The value must be between '0' and '922337203685477.00'</span>" style="display: none" runat="server"></asp:RangeValidator>
                                </dd>
                                <dt class="col-md-4">
                                    <label>Qty:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:TextBox ID="invQuantityInsert" class="form-control" runat="server" Text='<%# Bind("invQuantity") %>' />
                                    <asp:RangeValidator ControlToValidate="invQuantityInsert" MinimumValue="0" MaximumValue="2147483647" Type="Integer" ErrorMessage="<span class='text-danger'><strong>Qty:</strong> The value must be between '0' and '2147483647'</span>" style="display: none" runat="server"></asp:RangeValidator>
                                </dd>
                                <dt class="col-md-4">
                                    <label>Size:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:TextBox ID="invSizeInsert" class="form-control" placeholder="Eg. 3.12" runat="server" Text='<%# Bind("invSize") %>' />
                                    <asp:RangeValidator ControlToValidate="invSizeInsert" MinimumValue="0" MaximumValue="999.99" Type="Double" ErrorMessage="<span class='text-danger'><strong>Size:</strong> The value must be between '0' and '999.99'</span>" style="display: none" runat="server"></asp:RangeValidator>
                                </dd>
                                <dt class="col-md-4">
                                    <label>Units:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:TextBox ID="invMeasureInsert" class="form-control" runat="server" Text='<%# Bind("invMeasure") %>' />
                                    <asp:RegularExpressionValidator ControlToValidate="invMeasureInsert" ValidationExpression="^.{0,20}$" ErrorMessage="<span class='text-danger'><strong>Units:</strong> Enter a 20 chars MAX string</span>" style="display: none" runat="server"></asp:RegularExpressionValidator>
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
                                <h5 class="col-md-12 text-center font-weight-bold">Inventory Details</h5>
                                <dt class="col-md-4">
                                    <label>ID:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:Label ID="idLabel" runat="server" Text='<%# Eval("id") %>' />
                                </dd>
                                <dt class="col-md-4">
                                    <label>Product:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:DropDownList ID="ddlProdItem" runat="server" Text='<%# Bind("productID") %>' DataSourceID="ObjectDataSource3" DataTextField="prodName" DataValueField="id" TabIndex="-1" Style="appearance: none; border: none; background: none; pointer-events: none; color: #212529" AutoPostBack="True"></asp:DropDownList>
                                </dd>
                                <dt class="col-md-4">
                                    <label>Price:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:Label ID="invPriceLabel" runat="server" Text='<%# Bind("invPrice", "{0:c}") %>' />
                                </dd>
                                <dt class="col-md-4">
                                    <label>Qty:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:Label ID="invQuantityLabel" runat="server" Text='<%# Bind("invQuantity") %>' />
                                </dd>
                                <dt class="col-md-4">
                                    <label>Size:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:Label ID="invSizeLabel" runat="server" Text='<%# Bind("invSize", "{0:0.###}") %>' />
                                </dd>
                                <dt class="col-md-4">
                                    <label>Units:</label>
                                </dt>
                                <dd class="col-md-8">
                                    <asp:Label ID="invMeasureLabel" runat="server" Text='<%# Bind("invMeasure") %>' />
                                </dd>
                            </dl>
                            <div class="d-flex justify-content-around col-md-8 offset-md-2">
                                <asp:Button ID="EditButton" class="btn btn-outline-primary btn-sm" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                                &nbsp;<asp:Button ID="DeleteButton" class="btn btn-outline-danger btn-sm" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this record?')" />
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:FormView>
            </div>
        </div>
    </div>
    <br />

    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="LibraryFinal.EmmasDataSetTableAdapters.InventoryTableAdapter" OnSelected="ObjectDataSource1_Selected">
        <SelectParameters>
            <asp:ControlParameter ControlID="invSearch" DefaultValue="" Name="invSearch" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="LibraryFinal.EmmasDataSetTableAdapters.InventoryCRUDTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
        <DeleteParameters>
            <asp:Parameter Name="Original_id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="invQuantity" Type="Int32" />
            <asp:Parameter Name="invSize" Type="Decimal" />
            <asp:Parameter Name="invMeasure" Type="String" />
            <asp:Parameter Name="invPrice" Type="Decimal" />
            <asp:Parameter Name="productID" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="gvInventory" DefaultValue="" Name="Param1" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="invQuantity" Type="Int32" />
            <asp:Parameter Name="invSize" Type="Decimal" />
            <asp:Parameter Name="invMeasure" Type="String" />
            <asp:Parameter Name="invPrice" Type="Decimal" />
            <asp:Parameter Name="productID" Type="Int32" />
            <asp:Parameter Name="Original_id" Type="Int32" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="LibraryFinal.EmmasDataSetTableAdapters.ProductTableAdapter"></asp:ObjectDataSource>
</asp:Content>
