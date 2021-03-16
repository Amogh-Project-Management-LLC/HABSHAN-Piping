<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Mat_Transf_Items.aspx.cs" Inherits="Erection_Additional_MatItems" Title="Material Transfer" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= itemsGridView.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
            var masterTable = $find("<%=itemsGridView.ClientID %>").get_masterTableView();
            grid.get_element().style.height = (height) - 200 + "px";
            grid.get_element()
            grid.repaint();
        }
    </script>

    <div>
        <table style="width: 100%; background-color: gainsboro;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnEntry" runat="server" Text="Add New" Width="80" CausesValidation="false" OnClick="btnEntry_Click"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right">
                    <telerik:RadDropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="140px">
                    </telerik:RadDropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <table runat="server" id="EntryTable" visible="false">
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">Material Code
                </td>
                <td>
                    <telerik:RadComboBox ID="cboMatList" runat="server" AllowCustomText="True" DataSourceID="sqlMatSource" DataTextField="MAT_CODE1"
                        DataValueField="MAT_ID" Width="200px" OnSelectedIndexChanged="cboMatList_SelectedIndexChanged" AutoPostBack="true" CausesValidation="False">
                    </telerik:RadComboBox>
                    <asp:RequiredFieldValidator ID="matCodeValidator" runat="server" ControlToValidate="cboMatList"
                        ErrorMessage="*" ForeColor="Red" ValidationGroup="formAddNew"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">Heat No
                </td>
                <td>
                    <telerik:RadComboBox ID="txtAutoHeatNo" runat="server" Width="200px" DataSourceID="sqlHeatNo" DataTextField="HEAT_NO"
                        DataValueField="HEAT_NO" AllowCustomEntry="true" AllowCustomText="True" Filter="Contains" EnableTextSelection="true">
                    </telerik:RadComboBox>
                    <%--   <telerik:RadAutoCompleteBox ID="txtAutoHeatNo" runat="server" EmptyMessage="Start typing Heat No.." Width="200px" DataSourceID="sqlHeatNo" DataTextField="HEAT_NO" 
                        DataValueField="HEAT_NO" InputType="Text" AllowCustomEntry="true"></telerik:RadAutoCompleteBox>--%>
                    <asp:RequiredFieldValidator ID="hnValidator" runat="server" ControlToValidate="txtAutoHeatNo"
                        ErrorMessage="*" ForeColor="Red" ValidationGroup="formAddNew"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">Box No
                </td>
                <td>
                    <asp:TextBox ID="txtBoxNo" runat="server" Width="120px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="BoxNoValidator" runat="server" ControlToValidate="txtBoxNo"
                        ErrorMessage="*" ForeColor="Red" ValidationGroup="formAddNew"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">Paint Code
                </td>
                <td>
                    <telerik:RadDropDownList ID="ddlPaintSystem" runat="server" DataSourceID="sqlPaintSystem" DataTextField="PS" DataValueField="PS"
                        AppendDataBoundItems="true" OnDataBinding="ddlPaintSystem_DataBinding">
                    </telerik:RadDropDownList>
                    <asp:RequiredFieldValidator ID="PaintCodeValidator" runat="server" ControlToValidate="ddlPaintSystem"
                        ErrorMessage="*" ForeColor="Red" ValidationGroup="formAddNew"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">
                    <asp:Label ID="lblReqrd" runat="server" Text="Required Qty"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtReqQty" runat="server" Width="80px" Enabled="false"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">Transfer Qty
                </td>
                <td>
                    <telerik:RadTextBox ID="txtQty" runat="server" Width="80px"></telerik:RadTextBox>
                    <telerik:RadTextBox ID="txtPipePiece" runat="server" Width="120px" EmptyMessage="Pipe Piece Nos..."></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="qtyValidator" runat="server" ControlToValidate="txtQty"
                        ErrorMessage="*" ForeColor="Red" ValidationGroup="formAddNew"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">
                    <asp:Label ID="Label5" runat="server" Text="Remarks"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRemarks" runat="server" Width="350px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: left;">
                    <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click" Visible="false" ValidationGroup="formAddNew"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadLabel ID="lblFormMessage" runat="server" Text="" Font-Bold="true"></telerik:RadLabel>
                </td>
            </tr>
        </table>
    </div>
    <div>
        <telerik:RadGrid ID="itemsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataKeyNames="TRANSF_ITEM_ID" DataSourceID="itemsDataSource" SkinID="GridViewSkin"
            OnDataBound="itemsGridView_DataBound" PageSize="30" Width="100%">
            <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true"></ClientSettings>
            <MasterTableView EditMode="InPlace" AllowAutomaticUpdates="true" DataKeyNames="TRANSF_ITEM_ID" AllowAutomaticDeletes="true">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton" ItemStyle-Width="50px"></telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ConfirmText="Delete this Job Card?" ConfirmDialogType="RadWindow"
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                        UniqueName="DeleteColumn">
                        <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" Width="10px" />
                    </telerik:GridButtonColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" HeaderText="Mat Code" SortExpression="MAT_CODE1"
                        ReadOnly="True" />
                    <telerik:GridBoundColumn DataField="BOX_NO" HeaderText="Box No" SortExpression="BOX_NO" />
                    <telerik:GridTemplateColumn HeaderText="Paint Code" SortExpression="PAINT_CODE">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("PAINT_CODE") %>' Width="50px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("PAINT_CODE") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Heat Number" SortExpression="HEAT_NO">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("HEAT_NO") %>' Width="80px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("HEAT_NO") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Quantity" SortExpression="TRANSF_QTY">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("TRANSF_QTY") %>' Width="60px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("TRANSF_QTY") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="No of Piece" SortExpression="NO_OF_PIECE">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox4" runat="server" OnTextChanged="TextBox4_TextChanged" Text='<%# Bind("NO_OF_PIECE") %>'
                                Width="60px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("NO_OF_PIECE") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Pipe Length" SortExpression="PIPE_LENGTH">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("PIPE_LENGTH") %>' Width="60px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("PIPE_LENGTH") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Recv Date" SortExpression="RECEIVE_DATE">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("RECEIVE_DATE", "{0:dd-MMM-yyyy}") %>'
                                Width="85px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label6" runat="server" Text='<%# Bind("RECEIVE_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsMaterialBTableAdapters.PIP_MAT_TRANSF_DETAILTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_TRANSF_ITEM_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="HEAT_NO" Type="String" />
            <asp:Parameter Name="TRANSF_QTY" Type="Decimal" />
            <asp:Parameter Name="BOX_NO" Type="String" />
            <asp:Parameter Name="NO_OF_PIECE" Type="Decimal" />
            <asp:Parameter Name="PIPE_LENGTH" Type="Decimal" />
            <asp:Parameter Name="PAINT_CODE" Type="String" />
            <asp:Parameter Name="RECEIVE_DATE" Type="DateTime" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_TRANSF_ITEM_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="TRANSF_ID" QueryStringField="TRANSF_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="sqlMatSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlHeatNo" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlPaintSystem" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"></asp:SqlDataSource>
</asp:Content>
