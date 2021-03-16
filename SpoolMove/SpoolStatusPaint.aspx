<%@ Page Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true"
    CodeFile="SpoolStatusPaint.aspx.cs" Inherits="SpoolStatusPaint" Title="Paint Status" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:DetailsView ID="SpoolDetailsView" runat="server" AutoGenerateRows="False" SkinID="DetailsViewSkin" 
                DataSourceID="spoolFabDataSource" Width="650px" DataKeyNames="SPL_ID"
                OnModeChanging="SpoolDetailsView_ModeChanging" OnItemUpdating="SpoolDetailsView_ItemUpdating">
                <EmptyDataTemplate>
                    No Data to display!
                </EmptyDataTemplate>
                <Fields>
                    <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/icon-cancel.gif" EditImageUrl="~/Images/icon-edit.gif"
                        ShowEditButton="True" UpdateImageUrl="~/Images/icon-save.gif" />
                    <asp:BoundField DataField="PNT_REQ_NO" HeaderText="Paint Req No" SortExpression="PNT_REQ_NO" ReadOnly="true" />
                    <asp:BoundField DataField="REQ_DATE" HeaderText="Paint Req No" SortExpression="REQ_DATE" ReadOnly="true"
                        DataFormatString="{0:dd-MMM-yyyy}" ApplyFormatInEditMode="true" HtmlEncode="false" />
                    <asp:BoundField DataField="FST_COAT_REP" HeaderText="Primer Rep No" SortExpression="FST_COAT_REP" />
                    <asp:TemplateField HeaderText="Primer Rep Date" SortExpression="FST_COAT_DT">
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="txtDate1" runat="server" dbSelectedDate='<%# Bind("FST_COAT_DT") %>'
                                DateInput-DateFormat="dd-MMM-yyyy" Width="120px">
                            </telerik:RadDatePicker>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("FST_COAT_DT", "{0:dd-MMM-yyyy}") %>'></asp:TextBox>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("FST_COAT_DT", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="SND_COAT_REP" HeaderText="Inter. Rep No" SortExpression="SND_COAT_REP" />
                    <asp:TemplateField HeaderText="Inter. Rep Date" SortExpression="SND_COAT_DT">
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="txtDate2" runat="server" dbSelectedDate='<%# Bind("SND_COAT_DT") %>'
                                DateInput-DateFormat="dd-MMM-yyyy" Width="120px">
                            </telerik:RadDatePicker>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("SND_COAT_DT", "{0:dd-MMM-yyyy}") %>'></asp:TextBox>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("SND_COAT_DT", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="TRD_COAT_REP" HeaderText="Final Rep No" SortExpression="TRD_COAT_REP" />
                    <asp:TemplateField HeaderText="Final Rep Date" SortExpression="TRD_COAT_DT">
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="txtDate3" runat="server" dbSelectedDate='<%# Bind("TRD_COAT_DT") %>'
                                DateInput-DateFormat="dd-MMM-yyyy" Width="120px"></telerik:RadDatePicker>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("TRD_COAT_DT", "{0:dd-MMM-yyyy}") %>'></asp:TextBox>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("TRD_COAT_DT", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Fields>
            </asp:DetailsView>
        </ContentTemplate>
    </asp:UpdatePanel>

    <asp:SqlDataSource ID="spoolFabDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SPL_ID, PNT_REQ_NO, REQ_DATE, FST_COAT_REP, FST_COAT_DT, SND_COAT_REP, SND_COAT_DT, TRD_COAT_REP, TRD_COAT_DT FROM VIEW_SPL_ID_PAINT_REQ WHERE (SPL_ID = :SPL_ID)"
        UpdateCommand="UPDATE PIP_PAINTING_SPL_DETAIL SET FST_COAT_REP = :FST_COAT_REP, SND_COAT_REP = :SND_COAT_REP, TRD_COAT_REP = :TRD_COAT_REP, FST_COAT_DT = :FST_COAT_DT, SND_COAT_DT = :SND_COAT_DT, TRD_COAT_DT = :TRD_COAT_DT WHERE (SPL_ID = :SPL_ID)">
        <SelectParameters>            
            <asp:QueryStringParameter DefaultValue="-1" Name="SPL_ID" QueryStringField="SPL_ID" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="FST_COAT_REP" />
            <asp:Parameter Name="SND_COAT_REP" />
            <asp:Parameter Name="TRD_COAT_REP" />
            <asp:Parameter Name="FST_COAT_DT" />
            <asp:Parameter Name="SND_COAT_DT" />
            <asp:Parameter Name="TRD_COAT_DT" />
            <asp:Parameter Name="SPL_ID" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>