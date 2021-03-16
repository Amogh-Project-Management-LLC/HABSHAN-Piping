<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Supp_JobCard.aspx.cs" Inherits="Supp_JobCard" Title="Support Job Card" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div style="width: 100%; background-color: gainsboro;">
        <table style="width: 100%">
            <tr>
                <td>
                    <telerik:RadButton ID="btnRegist" runat="server" Text="New" Width="80" OnClick="btnRegist_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnView" runat="server" Text="Support List" Width="110" OnClick="btnView_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnSelectSupports" runat="server" Text="Select Supports" Width="120" OnClick="btnSelectSupports_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnUpdateJc" runat="server" Text="Update JC" Width="100" OnClick="btnUpdateJc_Click"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <telerik:RadTextBox ID="txtSearch" runat="server" OnTextChanged="txtSearch_TextChanged"
                        AutoPostBack="true" EmptyMessage="Search Here" Width="195px">
                    </telerik:RadTextBox>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <telerik:RadGrid ID="rowsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    DataSourceID="rowsDataSource" Width="100%" DataKeyNames="JC_ID" SkinID="GridViewSkin"
                    PageSize="14" OnRowEditing="rowsGridView_RowEditing">
                    <ClientSettings Selecting-AllowRowSelect="true"></ClientSettings>
                    <MasterTableView DataKeyNames="JC_ID" AllowAutomaticUpdates="true" EditMode="InPlace">
                    <Columns>
                       <telerik:GridEditCommandColumn ButtonType="ImageButton">
                           <ItemStyle Width="20px" />
                       </telerik:GridEditCommandColumn>                        
                        <telerik:GridBoundColumn DataField="JC_NO" HeaderText="Job Card No" SortExpression="JC_NO" />
                        
                        <telerik:GridTemplateColumn HeaderText="Subcon" SortExpression="SUB_CON_NAME">
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddSubcon" runat="server" AppendDataBoundItems="True" DataSourceID="SubconDataSource"
                                    DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" SelectedValue='<%# Bind("SUB_CON_ID") %>'
                                    Width="120px">
                                    <asp:ListItem></asp:ListItem>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("SUB_CON_NAME") %>'></asp:Label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Fab Shop" SortExpression="SHOP_NO">
                            <EditItemTemplate>
                                <asp:DropDownList ID="DropDownList11" runat="server" DataSourceID="shopDataSource"
                                    DataTextField="SHOP_NAME" DataValueField="SHOP_ID" SelectedValue='<%# Bind("SHOP_ID") %>'
                                    Width="150px" AppendDataBoundItems="True">
                                    <asp:ListItem></asp:ListItem>
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="shopDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
                                    ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT SHOP_ID, SHOP_NAME FROM PIP_FAB_SHOP WHERE (PROJECT_ID = :PROJECT_ID) ORDER BY SHOP_NAME'>
                                    <SelectParameters>
                                        <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label11" runat="server" Text='<%# Eval("SHOP_NAME") %>'></asp:Label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Create Date" SortExpression="CREATE_DATE">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("CREATE_DATE", "{0:dd-MMM-yyyy}") %>'
                                    Width="85px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("CREATE_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Revision" SortExpression="JC_REV">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("JC_REV") %>' Width="50px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label4" runat="server" Text='<%# Bind("JC_REV") %>'></asp:Label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="PS" SortExpression="PAINT_CODE">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("PAINT_CODE") %>' Width="60px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label5" runat="server" Text='<%# Bind("PAINT_CODE") %>'></asp:Label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Material Type" SortExpression="JC_MAT_TYPE">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("JC_MAT_TYPE") %>' Width="70px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label6" runat="server" Text='<%# Bind("JC_MAT_TYPE") %>'></asp:Label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Target" SortExpression="TARGET_CMPLT">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("TARGET_CMPLT", "{0:dd-MMM-yyyy}") %>'
                                    Width="70px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label7" runat="server" Text='<%# Bind("TARGET_CMPLT", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn ConvertEmptyStringToNull="False" HeaderText="Site Instruc. No" SortExpression="SITE_INSTRUC_NO">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("SITE_INSTRUC_NO") %>' Width="100px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label12" runat="server" Text='<%# Eval("SITE_INSTRUC_NO") %>'></asp:Label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn ConvertEmptyStringToNull="False" HeaderText="Site Instruc. Date" SortExpression="SITE_INSTRUC_ISSUE_DATE">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("SITE_INSTRUC_ISSUE_DATE", "{0:dd-MMM-yyyy}") %>' Width="80px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label13" runat="server" Text='<%# Eval("SITE_INSTRUC_ISSUE_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                    </Columns>
                        </MasterTableView>
                </telerik:RadGrid>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <div>
        <table style="width: 100%; background-color: gainsboro;">
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
                <td style="width: 100%; text-align: right;">
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>
                            <asp:DropDownList ID="cboReports" runat="server" AppendDataBoundItems="True" Width="350px" AutoPostBack="False">
                                <asp:ListItem Value="3" Selected="True">Request for Fabtication - Summary</asp:ListItem>
                                <asp:ListItem Value="4">Request for Fabtication - PCWBS</asp:ListItem>
                                <asp:ListItem Value="2">Material Pick Ticket</asp:ListItem>
                                <asp:ListItem Value="1">Request for Fabtication - Iso Wise</asp:ListItem>
                            </asp:DropDownList>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
                <td>
                    <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" Width="80" OnClick="btnPreview_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <asp:ObjectDataSource ID="rowsDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsSupp_BTableAdapters.VIEW_ADP_SUPP_JCTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_JC_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="JC_NO" Type="String" />
            <asp:Parameter Name="CREATE_DATE" Type="DateTime" />
            <asp:Parameter Name="JC_REV" Type="String" />
            <asp:Parameter Name="SUB_CON_ID" Type="Decimal" />
            <asp:Parameter Name="JC_MAT_TYPE" Type="String" />
            <asp:Parameter Name="TARGET_CMPLT" Type="DateTime" />
            <asp:Parameter Name="PAINT_CODE" Type="String" />
            <asp:Parameter Name="SHOP_ID" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="SITE_INSTRUC_NO" Type="String" />
            <asp:Parameter Name="SITE_INSTRUC_ISSUE_DATE" Type="DateTime" />
            <asp:Parameter Name="Original_JC_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="JC_NO" PropertyName="Text"
                Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE (PROJ_ID = :PROJECT_ID) ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="PS_SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT SUPP_PAINT_CODE FROM VIEW_ADP_SUPP_JC_DT WHERE (JC_ID = :JC_ID) AND SUPP_PAINT_CODE IS NOT NULL ORDER BY SUPP_PAINT_CODE">
        <SelectParameters>
            <asp:ControlParameter ControlID="rowsGridView" DefaultValue="-1" Name="JC_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>