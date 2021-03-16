<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" Theme="Blue"
    CodeFile="WelderLot.aspx.cs" Inherits="WeldingInspec_WelderLot" Title="Welders Lots" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <table style="width: 100%; background-color: whitesmoke">
            <tr>
                <td>
                    <telerik:RadButton ID="btnNew" runat="server" Text="New" Width="80" OnClick="btnNew_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80" OnClick="btnSave_Click"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="120px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>
    <table style="width: 100%">
        <tr>
            <td>
                <table id="EntryTable" runat="server" width="100%" visible="false">
                    <tr>
                        <td style="width: 110px; background-color: gainsboro;">Welder No
                        </td>
                        <td>
                            <asp:DropDownList ID="ddWelderNos" runat="server" DataSourceID="weldersDataSource"
                                DataTextField="WELDER_NO" DataValueField="WELDER_ID" Width="100px" AppendDataBoundItems="True"
                                OnDataBinding="ddWelderNos_DataBinding" AutoPostBack="True" OnSelectedIndexChanged="ddWelderNos_SelectedIndexChanged">
                            </asp:DropDownList>
                            <asp:CompareValidator ID="WelderNoValidator" runat="server" ControlToValidate="ddWelderNos"
                                ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr style="color: #000000">
                        <td style="width: 110px; background-color: gainsboro;">Lot No
                        </td>
                        <td>
                            <asp:TextBox ID="txtLotNo" runat="server" Width="150px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="LotNoFieldValidator" runat="server" ControlToValidate="txtLotNo"
                                ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadGrid ID="welderGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    DataKeyNames="LOT_ID" DataSourceID="WelderDataSource" 
                    PageSize="20" OnRowUpdating="welderGridView_RowUpdating" Width="100%" OnDataBound="welderGridView_DataBound">
                    <ClientSettings Selecting-AllowRowSelect="true"></ClientSettings>
                   <MasterTableView AllowAutomaticUpdates="true" DataKeyNames="LOT_ID">
                    <Columns>
                        <telerik:GridEditCommandColumn ButtonType="ImageButton"></telerik:GridEditCommandColumn>
                        
                        <telerik:GridBoundColumn DataField="WELDER_NO" HeaderText="Welder No" SortExpression="WELDER_NO"
                            ReadOnly="true" />
                        <telerik:GridBoundColumn DataField="LOT_NO" HeaderText="Lot No" SortExpression="LOT_NO" />
                        <telerik:GridBoundColumn DataField="CREATE_DATE" HeaderText="Create Date" SortExpression="CREATE_DATE"
                            ReadOnly="true" DataFormatString="{0:dd-MMM-yyyy}" 
                            HtmlEncode="false" />
                        <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                    </Columns>
                       </MasterTableView>                  
                </telerik:RadGrid>
            </td>
        </tr>
        <tr>
            <td style="background-color: whitesmoke;">
                <table>
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnJoints" runat="server" Text="Joints" Width="80" OnClick="btnJoints_Click"></telerik:RadButton>
                        </td>
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
            </td>
        </tr>
    </table>
    <asp:ObjectDataSource ID="WelderDataSource" runat="server" SelectMethod="GetData"
        TypeName="dsWeldersTableAdapters.VIEW_WELDER_LOTTableAdapter" UpdateMethod="UpdateQuery"
        DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}">
        <UpdateParameters>
            <asp:Parameter Name="LOT_NO" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_LOT_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:Parameter DefaultValue="%" Name="WELDER_NO" Type="String" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Original_LOT_ID" Type="Decimal" />
        </DeleteParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="weldersDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT WELDER_ID, WELDER_NO FROM PIP_WELDERS WHERE (PROJECT_ID = :PROJECT_ID) ORDER BY WELDER_NO">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>