<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="WPS_Details.aspx.cs" Inherits="WeldingInspec_WPS_Details" Title="WPS" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td style="width: 100px; background-color: whitesmoke;">
                <telerik:RadButton ID="btnBack" runat="server" OnClick="btnBack_Click" Text="Back" Width="80px"></telerik:RadButton>
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
                <asp:DetailsView ID="wpsDetailsView" runat="server" AutoGenerateRows="False" CssClass="DataWebControlStyle"
                    DataKeyNames="WPS_ID" DataSourceID="wpsDataSource" Height="50px" Width="731px"
                    OnItemUpdating="wpsDetailsView_ItemUpdating" OnModeChanging="wpsDetailsView_ModeChanging" BackColor="White" BorderColor="White" BorderStyle="Ridge" BorderWidth="2px" CellPadding="3" CellSpacing="1" GridLines="None">
                    <Fields>
                        <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/icon-cancel.gif" EditImageUrl="~/Images/icon-edit.gif"
                            ShowEditButton="True" UpdateImageUrl="~/Images/icon-save.gif" />
                        <asp:BoundField DataField="WPS_NO1" HeaderText="WPS No1" SortExpression="WPS_NO1" />
                        <asp:BoundField DataField="WPS_NO2" HeaderText="WPS No2" SortExpression="WPS_NO2" />
                        <asp:BoundField DataField="REV" HeaderText="Revision" SortExpression="REV" />
                        <asp:TemplateField HeaderText="Material" SortExpression="MATERIAL">
                            <EditItemTemplate>
                                <%--<asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("MATERIAL") %>' Width="360px"></asp:TextBox>--%>
                            <telerik:RadComboBox ID="cboMatList" runat="server" AllowCustomText="True" DataSourceID="sqlMatSource" 
                                DataTextField="MAT_TYPE" DataValueField="MAT_TYPE" Filter="Contains" SelectedValue='<%# Bind("MATERIAL") %>'></telerik:RadComboBox>

                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("MATERIAL") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                       <%-- <asp:TemplateField HeaderText="Pipe Class" SortExpression="PIPE_CLASS">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("PIPE_CLASS") %>' Width="360px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label4" runat="server" Text='<%# Bind("PIPE_CLASS") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                       <%-- <asp:BoundField DataField="PROCESS" HeaderText="Process" SortExpression="PROCESS" />--%>
                        <asp:TemplateField HeaderText="PROCESS" SortExpression="PROCESS">
                            <EditItemTemplate>
                               <%-- <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("PROCESS") %>' Width="360px"></asp:TextBox>--%>
                            <telerik:RadComboBox ID="cboProcessList" runat="server" AllowCustomText="True" DataSourceID="sqlProcessSource" 
                                DataTextField="WELD_PROCESS" DataValueField="WELD_PROCESS" Filter="Contains"
                                 SelectedValue='<%# Bind("PROCESS") %>'></telerik:RadComboBox>

                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label4" runat="server" Text='<%# Bind("PROCESS") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    

                          <asp:TemplateField HeaderText="PWHT" SortExpression="PWHT">
                            <EditItemTemplate>
                               <%-- <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("PROCESS") %>' Width="360px"></asp:TextBox>--%>
                            <telerik:RadComboBox ID="cboPWHT" runat="server" SelectedValue='<%# Bind("PWHT") %>'>
                                <Items>
                                    <telerik:RadComboBoxItem Text="(Select)" Value="" />
                                    <telerik:RadComboBoxItem Text="Y" Value="Y" />
                                    <telerik:RadComboBoxItem Text="N" Value="N" />
                                </Items>
                            </telerik:RadComboBox>

                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblPWHT" runat="server" Text='<%# Bind("PWHT") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField DataField="SIZE_FROM" HeaderText="Size From" SortExpression="SIZE_FROM" />
                        <asp:BoundField DataField="SIZE_TO" HeaderText="Size To" SortExpression="SIZE_TO" />
                        <asp:BoundField DataField="THK_FROM" HeaderText="Thick From" SortExpression="THK_FROM" />
                        <asp:BoundField DataField="THK_TO" HeaderText="Thick To" SortExpression="THK_TO" />
                        <%--<asp:BoundField DataField="CONNEC_A" HeaderText="Connection A" SortExpression="CONNEC_A" />--%>

                        <asp:TemplateField HeaderText="Connection A" SortExpression="CONNEC_A">
                            <EditItemTemplate>                               
                            <telerik:RadComboBox ID="cboConnA" runat="server" SelectedValue='<%# Bind("CONNEC_A") %>'>
                                <Items>
                                   <telerik:RadComboBoxItem Selected="True" Text="(Select)" Value=""></telerik:RadComboBoxItem>
                                    <telerik:RadComboBoxItem Text="PIPE" Value="PIPE"></telerik:RadComboBoxItem>
                                    <telerik:RadComboBoxItem Text="FITTING" Value="FITTING"></telerik:RadComboBoxItem>
                                </Items>
                            </telerik:RadComboBox>

                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblCONNEC_A" runat="server" Text='<%# Bind("CONNEC_A") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Connection B" SortExpression="CONNEC_B">
                            <EditItemTemplate>                               
                            <telerik:RadComboBox ID="cboConnB" runat="server" SelectedValue='<%# Bind("CONNEC_B") %>'>
                                <Items>
                                   <telerik:RadComboBoxItem Selected="True" Text="(Select)" Value=""></telerik:RadComboBoxItem>
                                    <telerik:RadComboBoxItem Text="PIPE" Value="PIPE"></telerik:RadComboBoxItem>
                                    <telerik:RadComboBoxItem Text="FITTING" Value="FITTING"></telerik:RadComboBoxItem>
                                </Items>
                            </telerik:RadComboBox>

                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblcboConnB" runat="server" Text='<%# Bind("CONNEC_B") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        
                        <asp:TemplateField HeaderText="Subcon" SortExpression="SUB_CON_NAME">
                            <EditItemTemplate>
                                <asp:DropDownList ID="cboSC" runat="server" AppendDataBoundItems="True" DataSourceID="subconDataSource"
                                    DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" SelectedValue='<%# Bind("SC_ID") %>'
                                    Width="114px">
                                    <asp:ListItem></asp:ListItem>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label5" runat="server" Text='<%# Bind("SUB_CON_NAME") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Remarks" SortExpression="REMARKS">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("REMARKS") %>' Width="360px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("REMARKS") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Fields>
                    <AlternatingRowStyle CssClass="AlternatingRowStyle" />
                    
                    <EmptyDataTemplate>
                        WPS Not Found!
                    </EmptyDataTemplate>
                    <FieldHeaderStyle Width="100px" />
                    <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#E7E7FF" />
                    <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Right" />
                    <RowStyle BackColor="#DEDFDE" ForeColor="Black" />
                </asp:DetailsView>
            </td>
        </tr>
    </table>
    <asp:ObjectDataSource ID="wpsDataSource" runat="server" SelectMethod="GetDataByWPS_ID"
        TypeName="dsWeldingBTableAdapters.PIP_WPS_NOTableAdapter" UpdateMethod="UpdateQuery"
        OldValuesParameterFormatString="original_{0}">
        <UpdateParameters>
            <asp:Parameter Name="WPS_NO1" Type="String" />
            <asp:Parameter Name="MATERIAL" Type="String" />
            <asp:Parameter Name="PROCESS" Type="String" />
            <asp:Parameter Name="PWHT" Type="String" />
            <asp:Parameter Name="SIZE_FROM" Type="Decimal" />
            <asp:Parameter Name="SIZE_TO" Type="Decimal" />
            <asp:Parameter Name="THK_FROM" Type="Decimal" />
            <asp:Parameter Name="THK_TO" Type="Decimal" />
            <asp:Parameter Name="CONNEC_A" Type="String" />
            <asp:Parameter Name="CONNEC_B" Type="String" />
            <asp:Parameter Name="WPS_NO2" Type="String" />
            <asp:Parameter Name="REV" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="SC_ID" Type="Decimal" />
            <asp:Parameter Name="original_WPS_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="WPS_ID" QueryStringField="WPS_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE PROJ_ID = :PROJECT_ID ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DirObjsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT DIR_ID, DIR_OBJ FROM DIR_OBJECTS WHERE (PROJECT_ID = :PROJECT_ID)'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>

     <asp:SqlDataSource ID="sqlMatSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT MAT_TYPE
FROM PIP_MAT_TYPE
WHERE PROJ_ID = :PROJ_ID
ORDER BY MAT_TYPE">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJ_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlProcessSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT WELD_PROCESS FROM PIP_WELD_PROCESS ORDER BY WELD_PROCESS"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlPipingClass" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PIPING_CLASS FROM PIPING_SPECS ORDER BY PIPING_CLASS"></asp:SqlDataSource>
</asp:Content>
