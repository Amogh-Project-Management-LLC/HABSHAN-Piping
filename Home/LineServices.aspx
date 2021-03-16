<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="LineServices.aspx.cs" Inherits="WeldingInspec_LineServices" Title="Line Services" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div style="background-color: whitesmoke; padding: 2px;">
          <telerik:RadButton ID="btnBack" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                                Text="Back" Width="80px" OnClick="btnBack_Click" />
         <telerik:RadButton ID="btnRegister" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                                Text="Register" Width="84px" OnClick="btnRegister_Click" />
    </div>
    <table style="width: 100%">
           <tr>
            <td style="width: 100%">
                <telerik:RadGrid ID="serviceGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    CssClass="DataWebControlStyle" DataKeyNames="LINE_SRV,PROJECT_ID" DataSourceID="LineSrvDataSource" AllowAutomaticDeletes="true" AllowAutomaticUpdates="true"
                    PageSize="12" Width="100%" OnRowUpdating="serviceGridView_RowUpdating" >
                    <ClientSettings>
                        <Selecting AllowRowSelect="true" />
                    </ClientSettings>
                    <MasterTableView DataSourceID="LineSrvDataSource" DataKeyNames="LINE_SRV,PROJECt_ID" EditMode="InPlace">
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                                <ItemStyle CssClass="MyImageButton" Width="10px" />
                            </telerik:GridEditCommandColumn>
                            <telerik:GridButtonColumn ConfirmText="Delete this Sub Store?" ConfirmDialogType="RadWindow"
                                ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                UniqueName="DeleteColumn">
                                <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" Width="10px" />
                            </telerik:GridButtonColumn>
                            <telerik:GridTemplateColumn HeaderText="Line Service" SortExpression="LINE_SRV">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("LINE_SRV") %>' Width="83px"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemStyle Width="100px" />
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("LINE_SRV") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="SRV_DESCR" HeaderText="Service Description" SortExpression="SRV_DESCR" />
                            <telerik:GridTemplateColumn HeaderText="Priority" SortExpression="PRIORITY">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="cboPriority" runat="server" AppendDataBoundItems="True" DataSourceID="priorityDataSource"
                                        DataTextField="TITLE" DataValueField="PRIORITY" SelectedValue='<%# Bind("PRIORITY") %>'
                                        Width="158px">
                                        <asp:ListItem></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("PRIORITY") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
    </table>
    <asp:ObjectDataSource ID="LineSrvDataSource" runat="server" SelectMethod="GetData"
        TypeName="dsGeneralTableAdapters.PIP_LINE_SERVICETableAdapter" UpdateMethod="UpdateQuery"
        DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}">
        <UpdateParameters>
            <asp:Parameter Name="LINE_SRV" Type="String" />
            <asp:Parameter Name="SRV_DESCR" Type="String" />
            <asp:Parameter Name="PRIORITY" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_LINE_SRV" Type="String" />
            <asp:Parameter Name="Original_PROJECT_ID" Type="Decimal" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="Original_LINE_SRV" Type="String" />
            <asp:Parameter Name="Original_PROJECT_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="priorityDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PRIORITY, PRIORITY || ': ' || DESCR AS TITLE FROM IPMS_PRIORITY ORDER BY PRIORITY"></asp:SqlDataSource>
</asp:Content>
