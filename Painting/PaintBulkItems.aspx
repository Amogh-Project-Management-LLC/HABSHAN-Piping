<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" Theme="Blue"
    CodeFile="PaintBulkItems.aspx.cs" Inherits="Painting_PaintBulkItems" Title="Paint Request" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke">
        <table style="width: 100%;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnEntry" runat="server" Text="Entry" Width="80" OnClick="btnEntry_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click" Visible="false"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="137px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <table width="100%" runat="server" visible="false" id="EntryTable">
            <tr>
                <td style="width: 180px; background-color: gainsboro;">Item Code
                </td>
                <td>
                    <div style="float: left">

                        <telerik:RadAutoCompleteBox ID="RadAutoCompleteBox1" InputType="Text" DropDownHeight="200px" DropDownWidth="350" runat="server" DataSourceID="ItemCodeDataSource"
                            DataTextField="MAT_CODE1" DataValueField="MAT_ID" Filter="StartsWith" MinFilterLength="2" Width="250px"
                            AllowCustomEntry="True" OnTextChanged="RadAutoCompleteBox1_TextChanged">
                            <TextSettings SelectionMode="Single" />
                        </telerik:RadAutoCompleteBox>
                    </div>
                    <div>
                        <asp:RequiredFieldValidator ID="matCodeValidator" runat="server" ControlToValidate="RadAutoCompleteBox1"
                            ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                </td>
            </tr>
            <tr>
                <td style="width: 180px; background-color: gainsboro;">Paint Code
                </td>
                <td>
                    <telerik:RadDropDownList ID="ddlPaintCode" runat="server" AppendDataBoundItems="True" DataSourceID="sqlPaintCode" DataTextField="PS" DataValueField="PS" OnDataBinding="ddlPaintCode_DataBinding"></telerik:RadDropDownList>
                    <asp:RequiredFieldValidator ID="PaintCodeValidator" runat="server" ControlToValidate="ddlPaintCode"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 180px; background-color: #99CCFF;">Qty Available</td>
                <td>
                    <asp:TextBox ID="txtAvlQty" runat="server" Width="80px" ReadOnly="True"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 180px; background-color: #99CCFF;">Qty Prev. Issued</td>
                <td>
                    <asp:TextBox ID="txtPrevJcQty" runat="server" Width="80px" ReadOnly="True"></asp:TextBox>
                </td>
            </tr>
            <%--<tr>
                <td style="width: 180px; background-color: #99CCFF;">Packing List Available Pipes</td>
                <td>
                    <asp:DropDownList ID="ddPklPipePiece" runat="server" Width="120px">
                    </asp:DropDownList>
                </td>
            </tr>--%>
            <tr>
                <td style="width: 180px; background-color: gainsboro;">Quantity/ Length
                </td>
                <td>
                    <asp:TextBox ID="txtReqQty" runat="server" Width="70px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequestQtyValidator" runat="server" ControlToValidate="txtReqQty"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 180px; background-color: gainsboro;">No of Pieces (Pipe)
                </td>
                <td>
                    <asp:TextBox ID="txtPipePcs" runat="server" Width="70px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="PipePcsValidator" runat="server" ControlToValidate="txtPipePcs"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
         
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="itemsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataSourceID="itemsDataSource" Width="100%" OnRowEditing="itemsGridView_RowEditing" AllowAutomaticDeletes="True"
             AllowAutomaticUpdates="True"
            OnDataBound="itemsGridView_DataBound" PageSize="20">
            <ClientSettings Selecting-AllowRowSelect="true"></ClientSettings>
            <MasterTableView EditMode="InPlace" AllowAutomaticUpdates="true" DataKeyNames="PAINT_ID,MAT_ID,PAINT_CODE"
                 AllowAutomaticDeletes="true">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton"></telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete"
                        ConfirmTextFormatString="Are you sure you want to delete {0}?"
                        ConfirmTextFields="MAT_CODE1"
                        ConfirmDialogType="RadWindow"></telerik:GridButtonColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" HeaderText="Mat Code" SortExpression="MAT_CODE1"
                        ReadOnly="true" />
                    <telerik:GridBoundColumn DataField="SIZE_DESC" HeaderText="Size" SortExpression="SIZE_DESC"
                        ReadOnly="true" />
                    <telerik:GridBoundColumn DataField="UOM" HeaderText="UOM" SortExpression="UOM" ReadOnly="true" />
                    <telerik:GridBoundColumn DataField="ITEM_NAM" HeaderText="Item" SortExpression="ITEM_NAM"
                        ReadOnly="true" />
                    <telerik:GridBoundColumn DataField="PAINT_CODE" HeaderText="Paint Code" SortExpression="PAINT_CODE"
                        ReadOnly="true" />
                    <telerik:GridTemplateColumn HeaderText="Pipe Qty" SortExpression="PIPE_PCS">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("PIPE_PCS") %>' Width="50"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("PIPE_PCS") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="QTY" SortExpression="QTY">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("QTY") %>' Width="50"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("QTY") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                
                    <telerik:GridBoundColumn DataField="SURFACE_SQM" HeaderText="Surface(SQM)" SortExpression="SURFACE_SQM"
                          ReadOnly="true" />
                  

                   
                 

                    <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

  
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsPaintingMatTableAdapters.VIEW_PAINTING_MAT_DETAILTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_PAINT_ID" Type="Decimal" />
            <asp:Parameter Name="Original_MAT_ID" Type="Decimal" />
            <asp:Parameter Name="Original_PAINT_CODE" Type="String" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="QTY" Type="Decimal" />
            <asp:Parameter Name="PIPE_PCS" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_PAINT_ID" Type="Decimal" />
            <asp:Parameter Name="Original_MAT_ID" Type="Decimal" />
            <asp:Parameter Name="Original_PAINT_CODE" Type="String" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="PAINT_ID" QueryStringField="PAINT_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="Store_SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT STORE_ID, STORE_NAME FROM STORES_DEF WHERE (PROJECT_ID = :PROJECT_ID) ORDER BY STORE_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="ItemCodeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT MAT_ID, MAT_CODE1 FROM PIP_MAT_STOCK WHERE (PROJ_ID = :PROJECT_ID) ORDER BY MAT_CODE1'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlPaintCode" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT PS 
FROM PIP_SPOOL
WHERE PS IS NOT NULL
ORDER BY PS"></asp:SqlDataSource>
</asp:Content>
