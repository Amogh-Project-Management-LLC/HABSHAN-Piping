<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Additional_Mat_Remain.aspx.cs" Inherits="Additional_Mat_Remain" Title="Additional Mat - Remain" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: gainsboro">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table>
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnregist" runat="server" Text="New" Width="80" OnClick="btnregist_Click" CausesValidation="false"></telerik:RadButton>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80" OnClick="btnSave_Click" Visible="false"></telerik:RadButton>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <div>
        <asp:UpdatePanel ID="entryUpdatePanel" runat="server">
            <ContentTemplate>
                <table style="width: 100%" runat="server" id="EntryTable" visible="false">
                    <tr>
                        <td style="width: 120px; background-color: whitesmoke;">Material Code
                        </td>
                        <td>
                            <telerik:RadSearchBox ID="txtSearchMatCode" runat="server" DataSourceID="sqlMatSource" DataTextField="MAT_CODE1"
                                DataValueField="MAT_CODE1" OnSearch="txtSearchMatCode_Search">
                            </telerik:RadSearchBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: whitesmoke;">Remain Serial
                        </td>
                        <td>
                            <telerik:RadDropDownList ID="ddRemains" runat="server" Width="180px" AppendDataBoundItems="True"
                                DataSourceID="newRemDataSource" DataTextField="REM_SERIAL" DataValueField="REM_ID"
                                OnDataBinding="ddRemains_DataBinding">
                            </telerik:RadDropDownList>
                            <asp:CompareValidator ID="remSerValidator" runat="server" ControlToValidate="ddRemains"
                                ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: whitesmoke;">Issued Qty
                        </td>
                        <td>
                            <asp:TextBox ID="txtQty" runat="server" Width="80px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="qtyValidator" runat="server" ControlToValidate="txtQty"
                                ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <div style="margin-top:3px">
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <telerik:RadGrid ID="returnGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    DataSourceID="itemsDataSource" PageSize="18" Width="100%" SkinID="GridViewSkin"
                    OnRowEditing="returnGridView_RowEditing" DataKeyNames="ADD_ISSUE_ID,REM_ID">
                    <ClientSettings Selecting-AllowRowSelect="true"></ClientSettings>
                    <MasterTableView DataKeyNames="ADD_ISSUE_ID,REM_ID" AllowAutomaticUpdates="true" EditMode="InPlace">
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton"></telerik:GridEditCommandColumn>                            
                            <telerik:GridBoundColumn DataField="REM_SERIAL" HeaderText="Remain Serial" SortExpression="REM_SERIAL"
                                ReadOnly="true" />
                            <telerik:GridBoundColumn DataField="ISSUE_NO" HeaderText="Issue No" SortExpression="ISSUE_NO"
                                ReadOnly="true" />
                            <telerik:GridBoundColumn DataField="MAT_CODE1" HeaderText="Mat Code" SortExpression="MAT_CODE1"
                                ReadOnly="true" />
                            <telerik:GridBoundColumn DataField="SIZE_DESC" HeaderText="Pipe Size" SortExpression="SIZE_DESC"
                                ReadOnly="true" />
                            <telerik:GridBoundColumn DataField="WALL_THK" HeaderText="Wall Thk" SortExpression="WALL_THK"
                                ReadOnly="true" />
                            <telerik:GridBoundColumn DataField="HEAT_NO" HeaderText="Heat No" SortExpression="HEAT_NO"
                                ReadOnly="true" />
                            <telerik:GridBoundColumn DataField="UOM" HeaderText="UOM" SortExpression="UOM" ReadOnly="true" />                            
                            <telerik:GridTemplateColumn HeaderText="Issued Qty" SortExpression="ISSUED_QTY">
                                <edititemtemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("ISSUED_QTY") %>' Width="60px"></asp:TextBox>
                            </edititemtemplate>
                                <itemtemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("ISSUED_QTY") %>'></asp:Label>
                            </itemtemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <div style="background-color: gainsboro; margin-top:3px">
        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
            <ContentTemplate>
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
                        <td>
                            <asp:HiddenField ID="matIdField" runat="server" OnValueChanged="matIdField_ValueChanged" />
                            <asp:HiddenField ID="scidField" runat="server" />
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsMaterial_IssueATableAdapters.VIEW_ADD_ISSUE_REMTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_ADD_ISSUE_ID" Type="Decimal" />
            <asp:Parameter Name="Original_REM_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="ISSUED_QTY" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_ADD_ISSUE_ID" Type="Decimal" />
            <asp:Parameter Name="Original_REM_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="ADD_ISSUE_ID" QueryStringField="ADD_ISSUE_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="newRemDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT REM_ID, REM_SERIAL
FROM VIEW_ADAPTER_PIPE_REM
WHERE (MAT_ID = :MAT_ID) AND (SC_ID = :SC_ID)
ORDER BY REM_SERIAL">
        <SelectParameters>
            <asp:ControlParameter ControlID="matIdField" DefaultValue="-1" Name="MAT_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="scidField" DefaultValue="-1" Name="SC_ID" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlMatSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT PIP_PIPE_REMAIN.MAT_ID, PIP_MAT_STOCK.MAT_CODE1 
FROM PIP_PIPE_REMAIN, PIP_MAT_STOCK
WHERE PIP_PIPE_REMAIN.MAT_ID = PIP_MAT_STOCK.MAT_ID
AND SC_ID = :SC_ID">
        <SelectParameters>
            <asp:ControlParameter ControlID="scidField" DefaultValue="-1" Name="SC_ID" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
