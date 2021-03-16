<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MaterialQuarantineDetail.aspx.cs" Inherits="Material_MaterialQuarantineDetail" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80px" OnClick="btnBack_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnAdd" runat="server" Text="Add Material" Width="100px" OnClick="btnAdd_Click"></telerik:RadButton>
    </div>
    <div>
        <table runat="server" id="EntryTable" visible="false">
            <tr>
                <td style="width: 120px; background-color: whitesmoke; padding-left:5px;">Mat Code:</td>
                <td>
                    <asp:TextBox ID="txtMatCode" runat="server" AutoPostBack="True"></asp:TextBox>
                    <asp:DropDownList ID="ddlMatItem" runat="server" AppendDataBoundItems="True"
                        OnDataBinding="ddlMatItem_OnDataBinding" DataSourceID="matSource"
                        DataTextField="MAT_CODE1" DataValueField="MAT_ID" Width="200px">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke; padding-left:5px;">Quantity:
                </td>
                <td>
                    <asp:TextBox ID="txtQty" runat="server" ValidationGroup="QTY"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                        ControlToValidate="txtQty" ErrorMessage="**" ValidationGroup="QTY"></asp:RequiredFieldValidator>
                </td>
            </tr>

            <tr>
                <td style="width: 120px; background-color: whitesmoke; padding-left:5px;">Category:</td>
                <td>
                    <asp:DropDownList ID="ddlQuaranCat" runat="server" AppendDataBoundItems="True"
                        DataSourceID="QuanrantineCatSource" DataTextField="QUARAN_CAT_DESC"
                        DataValueField="QUARAN_CAT" Width="200px">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke; padding-left:5px;">Remarks:
                </td>
                <td>
                    <asp:TextBox ID="txtRemarks" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80px" OnClick="btnSave_Click"></telerik:RadButton>
                    <telerik:RadButton ID="btnHide" runat="server" Text="Hide" Width="80px" OnClick="btnHide_Click"></telerik:RadButton>

                </td>
            </tr>
        </table>
    </div>
    <div style="margin-top: 3px">
        <telerik:RadGrid ID="RadGrid1" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True" CellSpacing="0" GridLines="None" AutoGenerateColumns="False" DataSourceID="itemSource"
            PageSize="20" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True">
            <ClientSettings>
                <Selecting AllowRowSelect="True" />
            </ClientSettings>
            <MasterTableView DataKeyNames="QRNTINE_UNIQ_ID" DataSourceID="itemSource" EditMode="InPlace" EditFormSettings-EditColumn-ButtonType="ImageButton" ClientDataKeyNames="QRNTINE_UNIQ_ID">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                        <ItemStyle CssClass="MyImageButton" Width="20px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ConfirmTextFormatString="Delete this {0}?" ConfirmTextFields="MAT_CODE1" ConfirmDialogType="RadWindow"
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                        UniqueName="DeleteColumn">
                        <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" Width="20px" />
                    </telerik:GridButtonColumn>
                    <telerik:GridTemplateColumn DataField="QUARAN_CAT_DESC" FilterControlAltText="Filter QUARAN_CAT_DESC column"
                        HeaderText="QUARAN_CAT_DESC" SortExpression="QUARAN_CAT_DESC" UniqueName="QUARAN_CAT_DESC"
                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                        <EditItemTemplate>
                            <telerik:RadDropDownList ID="DropDownList11" runat="server" SelectedValue='<%# Bind("QUARAN_CAT") %>'
                                DataSourceID="QuanrantineCatSource" DataTextField="QUARAN_CAT_DESC"
                                DataValueField="QUARAN_CAT">
                            </telerik:RadDropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label11" runat="server" Text='<%# Bind("QUARAN_CAT_DESC") %>'></asp:Label>
                        </ItemTemplate>                        
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column"
                        HeaderText="MAT_CODE1" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1" ReadOnly="true"
                        AllowFiltering="false">                        
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="QTY" FilterControlAltText="Filter QTY column"
                        HeaderText="QTY" SortExpression="QTY" UniqueName="QTY" AllowFiltering="false">                        
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS"
                        SortExpression="REMARKS" UniqueName="REMARKS" AllowFiltering="False">                        
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="QuanrantineCatSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT QUARAN_CAT, QUARAN_CAT_DESC FROM PIP_QUARANTINE_CAT"></asp:SqlDataSource>


    <asp:SqlDataSource ID="subconSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR "></asp:SqlDataSource>


    <asp:SqlDataSource ID="matSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT MAT_ID, MAT_CODE1 FROM PIP_MAT_STOCK WHERE (MAT_CODE1 LIKE '%' || :MAT_CODE1 || '%')">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtMatCode" DefaultValue="XXX"
                Name="MAT_CODE1" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:ObjectDataSource ID="itemSource" runat="server"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData"
        TypeName="dsMaterialDTableAdapters.VIEW_QUARANTINE_DETAILTableAdapter"
        UpdateMethod="UpdateQuery" DeleteMethod="DeleteQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_QRNTINE_UNIQ_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="QTY" Type="Decimal" />
            <asp:Parameter Name="QUARAN_CAT" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_QRNTINE_UNIQ_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="QRNTINE_ID"
                QueryStringField="id" Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>

