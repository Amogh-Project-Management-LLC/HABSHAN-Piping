<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" Theme="Blue"
    CodeFile="JointsPaintItems.aspx.cs" Inherits="WeldingInspec_JointsPaintItems"
    Title="Joints Painting" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke;">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnEntry" runat="server" Text="Entry" Width="80" OnClick="btnEntry_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="jointsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataSourceID="ItemsDataSource" PageSize="18" Width="100%" 
            DataKeyNames="JOINT_ID,JNT_PNT_ID" OnRowUpdating="jointsGridView_RowUpdating"
            OnRowEditing="jointsGridView_RowEditing">
            <ClientSettings>
                <Selecting AllowRowSelect="true" />

            </ClientSettings>
            <MasterTableView>
                <Columns>
                   
                    
                    <telerik:GridButtonColumn ConfirmText="Delete this Paint Transmittal?" ConfirmDialogType="RadWindow"
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                        UniqueName="DeleteColumn">
                        <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" Width="10px" />
                    </telerik:GridButtonColumn>
                    <telerik:GridBoundColumn DataField="ISO_TITLE1" HeaderText="Isometric No" SortExpression="ISO_TITLE1"
                        ReadOnly="True" />
                    <telerik:GridBoundColumn DataField="SHEET" HeaderText="Sheet" SortExpression="SHEET" ReadOnly="True" />
                    <telerik:GridBoundColumn DataField="SPOOL" HeaderText="Spool" SortExpression="SPOOL" ReadOnly="True" />
                    <telerik:GridBoundColumn DataField="PS" HeaderText="PS" SortExpression="PS" ReadOnly="True" />
                    <telerik:GridBoundColumn DataField="JOINT_NO" HeaderText="Joint No" SortExpression="JOINT_NO" ReadOnly="True" />
                    <telerik:GridBoundColumn DataField="SYMBOL" HeaderText="Rev-Code" SortExpression="SYMBOL" ReadOnly="True" />
                    <telerik:GridBoundColumn DataField="SF" HeaderText="SF" SortExpression="SF" ReadOnly="True" />
                    <telerik:GridBoundColumn DataField="JOINT_SIZE" HeaderText="Joint Size" SortExpression="JOINT_SIZE" ReadOnly="True" />
                    <telerik:GridBoundColumn DataField="JOINT_TYPE" HeaderText="Joint Type" SortExpression="JOINT_TYPE" ReadOnly="True" />
                    <telerik:GridBoundColumn DataField="WELD_DATE" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Weld Date"
                        HtmlEncode="False" SortExpression="WELD_DATE" ReadOnly="True"  />
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

    <div>
        <table style="width: 100%; background-color: whitesmoke">
            <tr>
              
                <td style="width: 100%; text-align: right;">
                    <telerik:RadTextBox ID="txtIsome" runat="server" AutoPostBack="True" OnTextChanged="txtIsome_TextChanged"
                        EmptyMessage="Isometric No" Visible="False" Width="200px">
                    </telerik:RadTextBox>
                </td>
                <td>
                    <asp:DropDownList ID="cboNewJoint" runat="server" DataSourceID="newjointDataSource"
                        DataTextField="JNT_TITLE" DataValueField="JOINT_ID" Visible="False" Width="150px">
                    </asp:DropDownList>
                </td>
                <td>
                    <telerik:RadButton ID="btnAddJoint" runat="server" Text="Save" Width="80" OnClick="btnAddJoint_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <asp:ObjectDataSource ID="ItemsDataSource" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsWeldingBTableAdapters.PIP_JOINT_PAINT_DETAILTableAdapter"
        DeleteMethod="DeleteQuery">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="JNT_PNT_ID" QueryStringField="JNT_PNT_ID"
                Type="Decimal" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="original_JNT_PNT_ID" Type="Decimal" />
            <asp:Parameter Name="original_JOINT_ID" Type="Decimal" />
        </DeleteParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="newjointDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT JOINT_ID, JNT_TITLE FROM VIEW_JOINTS_SIMPLE_WELDING
WHERE ((ISO_TITLE1 = :ISO_TITLE1)
AND (PROJ_ID = :PROJECT_ID)
AND (CAT_ID=2)
AND (WELD_DATE IS NOT NULL))
ORDER BY ISO_ID,FNC_JNT_NO_DEC(JOINT_NO)">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtIsome" DefaultValue="~" Name="ISO_TITLE1" PropertyName="Text" />
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
