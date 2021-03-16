<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="HydroTest.aspx.cs" Inherits="HydroTest_HydroTest" Title="Hydro Test" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <table style="width: 100%; background-color: whitesmoke;">
            <tr>
               <%-- <td>
                    <telerik:RadButton ID="btnViewJoints" runat="server" Text="Joints" Width="80" OnClick="btnViewJoints_Click"></telerik:RadButton>
                </td>--%>

                  <td>
                    <telerik:RadButton ID="btnSpools" runat="server" Text="Spools" Width="80" OnClick="btnSpools_Click" ></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnNew" runat="server" Text="New" Width="80"></telerik:RadButton>
                </td>
                 <td>
                    <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" Width="80" OnClick="btnPreview_Click"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="140px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="TransGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataSourceID="TransDataSource" PageSize="18" AllowAutomaticDeletes="true" AllowAutomaticUpdates="true"
            Width="100%" DataKeyNames="TEST_ID" OnRowUpdating="TransGridView_RowUpdating" OnDataBound="TransGridView_DataBound">
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
            </ClientSettings>
            <MasterTableView DataSourceID="TransDataSource" DataKeyNames="TEST_ID" EditMode="InPlace">
                <Columns>
                     <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                        <ItemStyle CssClass="MyImageButton" Width="10px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ConfirmText="Delete?" ConfirmDialogType="RadWindow"
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                        UniqueName="DeleteColumn">
                        <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" Width="10px" />
                    </telerik:GridButtonColumn>
                    <telerik:GridBoundColumn DataField="TEST_NO" HeaderText="Test No" ReadOnly="true" SortExpression="TEST_NO" />
                    <telerik:GridBoundColumn DataField="ISSUE_DATE" HeaderText="Test Date" SortExpression="ISSUE_DATE" 
                        DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false"  />
                    <telerik:GridBoundColumn DataField="SUB_CON_NAME" HeaderText="Subcon" SortExpression="SUB_CON_NAME"
                        ReadOnly="true" />
                     <telerik:GridBoundColumn DataField="USER_NAME" HeaderText="Created By" SortExpression="USER_NAME" ReadOnly="true" />
                    <telerik:GridBoundColumn DataField="TEST_PRESS" HeaderText="Test Pressure" SortExpression="TEST_PRESS" />
                    <telerik:GridBoundColumn DataField="TEST_MEDIUM" HeaderText="Test Medium" SortExpression="TEST_MEDIUM" />
                    <telerik:GridBoundColumn DataField="HOLDING_TIME" HeaderText="Holding Time" SortExpression="HOLDING_TIME" />
                    <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

    
    <asp:ObjectDataSource ID="TransDataSource" runat="server" SelectMethod="GetData"
        TypeName="dsHydroTestTableAdapters.VIEW_HYDRO_TESTTableAdapter" UpdateMethod="UpdateQuery"
        DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}">
        <UpdateParameters>
            <asp:Parameter Name="ISSUE_DATE" Type="DateTime" />
            <asp:Parameter Name="TEST_PRESS" Type="String" />
            <asp:Parameter Name="TEST_MEDIUM" Type="String" />
            <asp:Parameter Name="HOLDING_TIME" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_TEST_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:Parameter Name="TEST_NO" Type="String" DefaultValue="%" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Original_TEST_ID" Type="Decimal" />
        </DeleteParameters>
    </asp:ObjectDataSource>
</asp:Content>
