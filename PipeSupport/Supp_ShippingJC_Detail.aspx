<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Supp_ShippingJC_Detail.aspx.cs" Inherits="Supp_ShippingJC_Detail" Title="Support Shipping JC" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: gainsboro">

        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnHideEnt" runat="server" Text="New" Width="80" OnClick="btnHideEnt_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click" Visible="false"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <table style="width: 100%" id="EntryTable" runat="server" visible="false">
            <tr>
                <td style="width: 130px; background-color: whitesmoke">Support Tag No</td>
                <td>
                    <telerik:RadAutoCompleteBox ID="RadAutoCompleteBox1" InputType="Text" DropDownHeight="200px" DropDownWidth="350" runat="server" DataSourceID="ItemCodeDataSource"
                        DataTextField="MAT_CODE1" DataValueField="MAT_ID" Filter="StartsWith" MinFilterLength="2" Width="250px"
                        AllowCustomEntry="false">
                        <TextSettings SelectionMode="Single" />
                    </telerik:RadAutoCompleteBox>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: whitesmoke">Area/ PCWBS</td>
                <td>
                    <asp:TextBox ID="txtArea" runat="server" Width="100px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="AreaValidator" runat="server" ControlToValidate="txtArea"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: whitesmoke">Paint Code</td>
                <td>
                    <asp:TextBox ID="txtPaintCode" runat="server" Width="80px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="PaintCodeValidator" runat="server" ControlToValidate="txtPaintCode"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: whitesmoke">Support Jobcard No</td>
                <td>
                    <asp:TextBox ID="txtJobcardNo" runat="server" Width="150px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="JobcardNoRequiredFieldValidator" runat="server" ControlToValidate="txtJobcardNo"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: whitesmoke">Box No
                </td>
                <td>
                    <asp:TextBox ID="txtBoxNo" runat="server" Width="150px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: whitesmoke">Support Quantity
                </td>
                <td>
                    <asp:TextBox ID="txtQty" runat="server" Width="50px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="qtyValidator" runat="server" ControlToValidate="txtQty"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: whitesmoke">Remarks
                </td>
                <td>
                    <asp:TextBox ID="txtRem" runat="server" Width="400px"></asp:TextBox>
                </td>
            </tr>
        </table>
    </div>

    <div>

        <telerik:RadGrid ID="itemsGridView" runat="server" AutoGenerateColumns="False" SkinID="GridViewSkin"
            DataKeyNames="SHIP_ID,MAT_ID,AREA_L1,PAINT_CODE,SUPP_FAB_JC_NO" DataSourceID="itemstDataSource" Width="100%"
            AllowPaging="True" PageSize="18" OnRowEditing="itemsGridView_RowEditing">
            <MasterTableView DataKeyNames="SHIP_ID,MAT_ID,AREA_L1,PAINT_CODE,SUPP_FAB_JC_NO" AllowAutomaticUpdates="true"
                 EditMode="InPlace">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="20px" />
                    </telerik:GridEditCommandColumn>
                    
                    <telerik:GridBoundColumn DataField="BOX_NO" HeaderText="Box No" SortExpression="BOX_NO" />
                    <telerik:GridBoundColumn DataField="MAT_CODE1" HeaderText="Tag No" SortExpression="MAT_CODE1"
                        ReadOnly="true" />
                    <telerik:GridBoundColumn DataField="AREA_L1" HeaderText="Area" SortExpression="AREA_L1" />
                    <telerik:GridBoundColumn DataField="PAINT_CODE" HeaderText="Paint Code" SortExpression="PAINT_CODE" />
                    <telerik:GridBoundColumn DataField="QTY" HeaderText="QTY" SortExpression="QTY" />
                    <telerik:GridBoundColumn DataField="ACTUAL_WT" HeaderText="Weight" SortExpression="ACTUAL_WT"
                        ReadOnly="true" />
                    <telerik:GridBoundColumn DataField="SUPP_FAB_JC_NO" HeaderText="Supp JC No" SortExpression="SUPP_FAB_JC_NO" />
                    <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

    <div style="background-color: gainsboro">

        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnDelete" runat="server" Text="Delete" Width="80" OnClick="btnDelete_Click" Skin="Sunset"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnYes" runat="server" Text="Yes" Width="50" OnClick="btnYes_Click" EnableViewState="false" Visible="false" Skin="Sunset"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnNo" runat="server" Text="No" Width="50" EnableViewState="false" Visible="false" Skin="Telerik"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <asp:ObjectDataSource ID="itemstDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsSupp_GTableAdapters.VIEW_SUPP_SHIP_JC_DTTableAdapter"
        UpdateMethod="UpdateQuery">
        <UpdateParameters>
            <asp:Parameter Name="BOX_NO" Type="String" />
            <asp:Parameter Name="QTY" Type="Decimal" />
            <asp:Parameter Name="AREA_L1" Type="String" />
            <asp:Parameter Name="PAINT_CODE" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="SUPP_FAB_JC_NO" Type="String" />
            <asp:Parameter Name="Original_SHIP_ID" Type="Decimal" />
            <asp:Parameter Name="Original_MAT_ID" Type="Decimal" />
            <asp:Parameter Name="Original_AREA_L1" Type="String" />
            <asp:Parameter Name="Original_PAINT_CODE" Type="String" />
            <asp:Parameter Name="Original_SUPP_FAB_JC_NO" Type="String" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="SHIP_ID" QueryStringField="SHIP_ID"
                Type="Decimal" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Original_SHIP_ID" Type="Decimal" />
            <asp:Parameter Name="Original_MAT_ID" Type="Decimal" />
            <asp:Parameter Name="Original_AREA_L1" Type="String" />
            <asp:Parameter Name="Original_PAINT_CODE" Type="String" />
            <asp:Parameter Name="Original_SUPP_FAB_JC_NO" Type="String" />
        </DeleteParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="ItemCodeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT MAT_ID, MAT_CODE1 FROM VIEW_STOCK WHERE (PROJ_ID = :PROJECT_ID) AND (IS_SUPP = &#039;Y&#039;) ORDER BY MAT_CODE1'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
