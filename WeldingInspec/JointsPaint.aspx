<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" Theme="Blue"
    CodeFile="JointsPaint.aspx.cs" Inherits="WeldingInspec_FieldJointsPaint" Title="Joints Paiting" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke">
        <table style="width: 100%;">
            <tr>
                  <td>
                    <telerik:RadButton ID="btnNew" runat="server" Text="Register" Width="80"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnViewJoints" runat="server" Text="Joints" Width="80" OnClick="btnViewJoints_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" Width="80" OnClick="btnPreview_Click"></telerik:RadButton>
                 </td>
              
                <td style="width: 100%; text-align: right;">
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="137px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="TransGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataSourceID="JntPaintDataSource" PageSize="18"
            Width="100%" DataKeyNames="JNT_PNT_ID" OnRowUpdating="TransGridView_RowUpdating"
            OnDataBound="TransGridView_DataBound">
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
            </ClientSettings>
            <MasterTableView DataKeyNames="JNT_PNT_ID" EditMode="InPlace">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                        <ItemStyle CssClass="MyImageButton" Width="10px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ConfirmText="Delete this Paint Transmittal?" ConfirmDialogType="RadWindow"
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                        UniqueName="DeleteColumn">
                        <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" Width="10px" />
                    </telerik:GridButtonColumn>

                    <telerik:GridBoundColumn DataField="JNT_PNT_NO" HeaderText="Joint Paint No" SortExpression="JNT_PNT_NO" ReadOnly="true" />
                    <telerik:GridBoundColumn DataField="ISSUE_DATE" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Issue Date" ReadOnly="true"
                        HtmlEncode="False" SortExpression="ISSUE_DATE">
                        <ItemStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ISSUED_BY" HeaderText="Issued by" SortExpression="ISSUED_BY" ReadOnly="true" />
                    <telerik:GridTemplateColumn HeaderText="Subcon" SortExpression="SUB_CON_NAME">
                        <EditItemTemplate>
                            <asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="True" DataSourceID="subconDataSource"
                                DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" SelectedValue='<%# Bind("SC_ID") %>'
                                Width="114px">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("SUB_CON_NAME") %>' Width="114px"></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>


    <asp:ObjectDataSource ID="JntPaintDataSource" runat="server" SelectMethod="GetData"
        TypeName="dsWeldingBTableAdapters.PIP_JOINT_PAINTTableAdapter" UpdateMethod="UpdateQuery"
        DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}">
        <UpdateParameters>
            <asp:Parameter Name="JNT_PNT_NO" Type="String" />
            <asp:Parameter Name="ISSUE_DATE" Type="DateTime" />
            <asp:Parameter Name="ISSUED_BY" Type="String" />
            <asp:Parameter Name="SC_ID" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_JNT_PNT_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Original_JNT_PNT_ID" Type="Decimal" />
        </DeleteParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="subconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT "SUB_CON_ID", "SUB_CON_NAME" FROM "SUB_CONTRACTOR" ORDER BY "SUB_CON_NAME"'></asp:SqlDataSource>
</asp:Content>
