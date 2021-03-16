<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SuppRequestDetail.aspx.cs" Inherits="PipeSupport_SuppRequestDetail"
    Title="Support Request" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table style="width: 100%">
                <tr>
                    <td style="background-color: whitesmoke">
                        <table>
                            <tr>
                                <td>
                                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80px" CausesValidation="False" OnClick="btnBack_Click" />
                                </td>
                                <td>
                                    <telerik:RadButton ID="btnHideEnt" runat="server" Text="Entry" Width="80px" CausesValidation="False" OnClick="btnHideEnt_Click" />
                                </td>
                                <td>
                                    <telerik:RadButton ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Save" Width="80px" Visible="False" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table style="width: 100%" class="TableStyle" id="EntryTable" runat="server" visible="false">
                            <tr>
                                <td style="width: 130px; background-color: whitesmoke">Area</td>
                                <td>
                                    <asp:TextBox ID="txtArea" runat="server" Width="100px"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="AreaValidator" runat="server" ControlToValidate="txtArea" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 130px; background-color: whitesmoke">Supp Tag No </td>
                                <td>
                                    <telerik:RadAutoCompleteBox ID="RadAutoCompleteBox1" runat="server" AllowCustomEntry="false" DataSourceID="ItemCodeDataSource" DataTextField="MAT_CODE1" DataValueField="MAT_ID" DropDownHeight="200px" DropDownWidth="350" Filter="StartsWith" InputType="Text" MinFilterLength="2" Width="250px">
                                        <TextSettings SelectionMode="Single" />
                                    </telerik:RadAutoCompleteBox>
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
                                <td style="width: 130px; background-color: whitesmoke">Total Weight</td>
                                <td>
                                    <asp:TextBox ID="txtWeight" runat="server" Width="50px"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="WeightFieldValidator" runat="server" ControlToValidate="txtWeight"
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
                    </td>
                </tr>
                <tr>
                    <td>
                        <telerik:RadGrid ID="itemsGridView" runat="server" AutoGenerateColumns="False" CssClass="DataWebControlStyle"
                            DataKeyNames="REQ_ID,AREA_L1,MAT_ID" DataSourceID="itemstDataSource" Width="100%"
                            AllowPaging="True" PageSize="15" OnRowEditing="itemsGridView_RowEditing">
                            <MasterTableView DataKeyNames="REQ_ID,AREA_L1,MAT_ID" AllowAutomaticUpdates="true">
                                <Columns>
                                    <telerik:GridEditCommandColumn ButtonType="ImageButton"></telerik:GridEditCommandColumn>                                    
                                    <telerik:GridBoundColumn DataField="AREA_L1" HeaderText="Area" SortExpression="AREA_L1" />
                                    <telerik:GridBoundColumn DataField="MAT_CODE1" HeaderText="Supp Tag" SortExpression="MAT_CODE1" ReadOnly="True" />
                                    <telerik:GridBoundColumn DataField="MAT_DESCR" HeaderText="Supp Desc" SortExpression="MAT_DESCR" ReadOnly="True" />
                                    <telerik:GridBoundColumn DataField="QTY" HeaderText="QTY" SortExpression="QTY" />
                                    <telerik:GridBoundColumn DataField="TOTAL_WEIGHT" HeaderText="Total Weight" SortExpression="TOTAL_WEIGHT" />
                                    <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </td>
                </tr>
                <tr>
                    <td style="background-color: whitesmoke">
                        <table>
                            <tr>
                                <td>
                                    <telerik:RadButton ID="btnDelete" runat="server" OnClick="btnDelete_Click" Text="Delete" Width="80px" CausesValidation="False" />
                                </td>
                                <td>
                                    <telerik:RadButton ID="btnYes" runat="server" EnableViewState="False" OnClick="btnYes_Click" Text="Yes" Visible="False" Width="44px"
                                        CausesValidation="False" />
                                </td>
                                <td>
                                    <telerik:RadButton ID="btnNo" runat="server" EnableViewState="False" Text="No" Visible="False" Width="44px" CausesValidation="False" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:ObjectDataSource ID="itemstDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsSupp_BTableAdapters.VIEW_SUPP_REQUEST_DTTableAdapter"
        UpdateMethod="UpdateQuery">
        <UpdateParameters>
            <asp:Parameter Name="AREA_L1" Type="String" />
            <asp:Parameter Name="QTY" Type="Decimal" />
            <asp:Parameter Name="TOTAL_WEIGHT" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_REQ_ID" Type="Decimal" />
            <asp:Parameter Name="Original_MAT_ID" Type="Decimal" />
            <asp:Parameter Name="Original_AREA_L1" Type="String" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="REQ_ID" QueryStringField="REQ_ID"
                Type="Decimal" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Original_REQ_ID" Type="Decimal" />
            <asp:Parameter Name="Original_MAT_ID" Type="Decimal" />
            <asp:Parameter Name="Original_AREA_L1" Type="String" />
        </DeleteParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="ItemCodeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT MAT_ID, MAT_CODE1 FROM VIEW_STOCK WHERE (PROJ_ID = :PROJECT_ID) AND (IS_SUPP = &#039;Y&#039;) ORDER BY MAT_CODE1'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
