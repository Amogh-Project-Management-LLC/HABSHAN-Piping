<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="TC_Details.aspx.cs" Inherits="HeatNo_TC_HN" Title="MTC" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <table style="width: 100%; background-color: gainsboro;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnEntry" runat="server" Text="New" Width="80" OnClick="btnEntry_Click" CausesValidation="false"></telerik:RadButton>
                </td>

                <td>
                    <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click" Visible="false"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right">
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="130px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <table runat="server" id="EntryTable" visible="false">
            <tr>
                <td style="width: 120px; background-color: whitesmoke">MR Item
                </td>
                <td>
                    <asp:TextBox ID="txtMrItem" runat="server" Width="40px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="mrItemValidator" runat="server" ControlToValidate="txtMrItem"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">PO Item
                </td>
                <td>
                    <asp:TextBox ID="txtPoItem" runat="server" Width="40px"></asp:TextBox><asp:RequiredFieldValidator
                        ID="poItemValidator" runat="server" ControlToValidate="txtPoItem" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">Material Code
                </td>
                <td>
                    <asp:TextBox ID="txtItemCode" runat="server" Width="283px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="matCodeFieldValidator1" runat="server" ControlToValidate="txtItemCode"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">Heat Number
                </td>
                <td>
                    <asp:TextBox ID="txtHeatNo" runat="server" Width="121px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="hnValidator2" runat="server" ControlToValidate="txtHeatNo"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">Quantity
                </td>
                <td>
                    <asp:TextBox ID="txtQty" runat="server" Width="99px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="qtyValidator" runat="server" ControlToValidate="txtQty"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">Remarks
                </td>
                <td>
                    <asp:TextBox ID="txtRemarks" runat="server" Width="406px"></asp:TextBox>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="tcDetailsGridView" runat="server" AutoGenerateColumns="False" SkinID="GridViewSkin"
            DataSourceID="tcDetailDataSource" AllowPaging="True" OnDataBound="tcDetailsGridView_DataBound"
            PageSize="18" Width="100%" DataKeyNames="TC_ITEM_ID">
            <ClientSettings Selecting-AllowRowSelect="true"></ClientSettings>
            <MasterTableView DataKeyNames="TC_ITEM_ID" AllowAutomaticUpdates="true" EditMode="InPlace">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton"></telerik:GridEditCommandColumn>                    
                    <telerik:GridTemplateColumn HeaderText="MR Item" SortExpression="MR_ITEM">
                        <edititemtemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("MR_ITEM") %>' Width="49px"></asp:TextBox>
                    </edititemtemplate>
                        <itemtemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("MR_ITEM") %>'></asp:Label>
                    </itemtemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="PO Item" SortExpression="PO_ITEM">
                        <edititemtemplate>
                        <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("PO_ITEM") %>' Width="39px"></asp:TextBox>
                    </edititemtemplate>
                        <itemtemplate>
                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("PO_ITEM") %>'></asp:Label>
                    </itemtemplate>
                    </telerik:GridTemplateColumn>                    
                    <telerik:GridBoundColumn DataField="TC_CODE" HeaderText="TC Code" ReadOnly="True" SortExpression="TC_CODE" />
                    <telerik:GridBoundColumn DataField="MAT_CODE1" HeaderText="Material Code" SortExpression="MAT_CODE1"
                        ReadOnly="True" />
                    <telerik:GridTemplateColumn HeaderText="Heat Number" SortExpression="HEAT_NO">
                        <edititemtemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("HEAT_NO") %>' Width="83px"></asp:TextBox>
                    </edititemtemplate>
                        <itemtemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("HEAT_NO") %>'></asp:Label>
                    </itemtemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Net Qty" SortExpression="NET_QTY">
                        <edititemtemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("NET_QTY") %>' Width="69px"></asp:TextBox>
                    </edititemtemplate>
                        <itemtemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("NET_QTY") %>'></asp:Label>
                    </itemtemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="UOM" HeaderText="UOM" ReadOnly="True" SortExpression="UOM" />
                    <telerik:GridTemplateColumn HeaderText="Remarks" SortExpression="REMARKS">
                        <edititemtemplate>
                        <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("REMARKS") %>'></asp:TextBox>
                    </edititemtemplate>
                        <itemtemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("REMARKS") %>'></asp:Label>
                    </itemtemplate>
                    </telerik:GridTemplateColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

    <div style="background-color: gainsboro;">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnDelete" runat="server" Text="Delete" Width="80" OnClick="btnDelete_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnYes" runat="server" Text="Yes" Width="50px" OnClick="btnYes_Click" Visible="False" EnableViewState="false" Skin="Sunset"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnNo" runat="server" Text="No" Width="50px" Visible="False" EnableViewState="false" Skin="Telerik"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <asp:ObjectDataSource ID="tcDetailDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsGeneralTableAdapters.PIP_TEST_CARDS_DETAILTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_TC_ITEM_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="HEAT_NO" Type="String" />
            <asp:Parameter Name="NET_QTY" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="MR_ITEM" Type="String" />
            <asp:Parameter Name="PO_ITEM" Type="String" />
            <asp:Parameter Name="Original_TC_ITEM_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="TC_ID" QueryStringField="TC_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
