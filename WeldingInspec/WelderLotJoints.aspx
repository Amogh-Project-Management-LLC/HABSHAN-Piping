<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" Theme="Blue"
    CodeFile="WelderLotJoints.aspx.cs" Inherits="WeldingInspec_WelderLotJoints" Title="Welders Lots" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <table style="width: 100%; background-color: whitesmoke">
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnAuto" runat="server" Text="Auto Update" Width="120" OnClick="btnAuto_Click"></telerik:RadButton>
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
                <telerik:RadGrid ID="welderGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    DataKeyNames="LOT_ID,JOINT_ID" DataSourceID="WelderDataSource" SkinID="GridViewSkin"
                    PageSize="20" OnRowUpdating="welderGridView_RowUpdating" Width="100%" OnDataBound="welderGridView_DataBound">
                    <MasterTableView>
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton"></telerik:GridEditCommandColumn>                            
                            <telerik:GridBoundColumn DataField="ISO_TITLE1" HeaderText="Isometric No" SortExpression="ISO_TITLE1" />
                            <telerik:GridBoundColumn DataField="SHEET" HeaderText="Sheet" SortExpression="SHEET" />
                            <telerik:GridBoundColumn DataField="SPOOL" HeaderText="Spool" SortExpression="SPOOL" />
                            <telerik:GridBoundColumn DataField="JOINT_NO" HeaderText="Joint No" SortExpression="JOINT_NO" />
                            <telerik:GridBoundColumn DataField="JOINT_TYPE" HeaderText="Joint Type" SortExpression="JOINT_TYPE" />
                            <telerik:GridBoundColumn DataField="WELD_DATE" HeaderText="Weld Date" SortExpression="WELD_DATE"
                                DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" />
                            <telerik:GridBoundColumn DataField="ROOT1" HeaderText="Root1" SortExpression="ROOT1" />
                            <telerik:GridBoundColumn DataField="ROOT2" HeaderText="Root2" SortExpression="ROOT2" />
                            <telerik:GridBoundColumn DataField="COVER1" HeaderText="Cover1" SortExpression="COVER1" />
                            <telerik:GridBoundColumn DataField="COVER2" HeaderText="Cover2" SortExpression="COVER2" />
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
        TypeName="dsWeldersTableAdapters.VIEW_WELDER_LOT_JOINTTableAdapter" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="LOT_ID" QueryStringField="LOT_ID"
                Type="Decimal" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Original_LOT_ID" Type="Decimal" />
            <asp:Parameter Name="Original_JOINT_ID" Type="Decimal" />
        </DeleteParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE (PROJ_ID = :PROJECT_ID) ORDER BY SUB_CON_NAME'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
