<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="JobCard_Select.aspx.cs" Inherits="SpoolFabJobCard_JobCard_Select"
    Title="Spool Selection" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td style="background-color: whitesmoke">
                <%--  <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                    <ContentTemplate>--%>
                <table>
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                        </td>
                        <td>
                            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                <ContentTemplate>
                                    <telerik:RadButton ID="btnApplyFilter" runat="server" Text="Apply Filter" Width="110" OnClick="btnApplyFilter_Click" CausesValidation="false"></telerik:RadButton>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80" OnClick="btnMbrs_Click"></telerik:RadButton>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnBulkImportSpl" runat="server" Text="Bulk Import Spools" Width="140" OnClick="btnBulkImportSpl_Click"></telerik:RadButton>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnSpoolDownload" runat="server" Text="JC Eligible Spools" Width="140" OnClick="btnSpoolDownload_Click"></telerik:RadButton>

                        </td>
                        <td style="width: 100%; text-align: center;">
                            <asp:UpdateProgress ID="UpdateProgress1" runat="server" DisplayAfter="10">
                                <ProgressTemplate>
                                    <img src="../Images/ajax-loader-bar.gif" />
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                        </td>
                    </tr>
                </table>
             <%--      </ContentTemplate>
                </asp:UpdatePanel>--%>
            </td>
        </tr>
        <tr>
            <td>
                <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                    <ContentTemplate>
                        <table style="width: 100%;">
                            <tr>
                                <td style="width: 160px; background-color: whitesmoke;">Size Range</td>
                                <td style="text-align: left">
                                    <table>
                                        <tr>
                                            <td>
                                                <telerik:RadComboBox ID="rcbSize" runat="server" DataSourceID="SizeDataSource" DataTextField="RANGE_B" DataValueField="RANGE_B"
                                                    AppendDataBoundItems="true" OnDataBinding="rcbSize_DataBinding">
                                                </telerik:RadComboBox>
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="AnySize_CheckBox" runat="server" AutoPostBack="True" Text="Any Size" OnCheckedChanged="AnySize_CheckBox_CheckedChanged" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 160px; background-color: whitesmoke;">Isometric No</td>
                                <td style="text-align: left">
                                    <telerik:RadTextBox ID="txtIsometric" runat="server" Width="200"></telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 160px; background-color: whitesmoke;">SFR</td>
                                <td style="text-align: left">
                                    <asp:DropDownList ID="ddSFR" runat="server" Width="70px">
                                        <asp:ListItem Selected="True" Value="XXX">Any</asp:ListItem>
                                        <asp:ListItem Value="N">Spool</asp:ListItem>
                                        <asp:ListItem Value="Y">SFR</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr>
            <td>
                <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                    <ContentTemplate>
                        <table>
                            <tr>
                                <td style="background-color: whitesmoke; border-radius: 4px; text-align: center; height: 21px;">All Spools
                                </td>
                                <td style="background-color: whitesmoke; border-radius: 4px; text-align: center; height: 21px;">Selected Spools
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadListBox ID="All_Spools" runat="server" Width="500px" Height="350px" DataSourceID="AllSpoolsDataSource"
                                        DataTextField="SPL_TITLE" DataValueField="SPL_ID" AllowTransfer="True" TransferToID="Selected_Spools" SelectionMode="Multiple" OnDataBound="All_Spools_DataBound">
                                    </telerik:RadListBox>
                                </td>

                                <td style="vertical-align: top">
                                    <telerik:RadListBox ID="Selected_Spools" runat="server" Width="500px" Height="350px" SelectionMode="Multiple"></telerik:RadListBox>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="AllSpoolsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SPL_ID, SPL_TITLE FROM VIEW_SPL_WITH_STATUS
                                                                                                 WHERE (PROJ_ID = :PROJ_ID) AND
                                                                                                 (SFR = :SFR OR :SFR = 'XXX') AND
                                                                                                 ((RANGE_B=:RANGE) OR :ALL_SIZE = 'Y') AND
                                                                                                 ISO_TITLE1 LIKE FNC_FILTER(:ISO_TITLE1) AND
                                                                                                 (SML_SC = :SML_SC) AND
                                                                                                 (FAB_SC=:SML_SC) AND
                                                                                                 (HOLD_STATUS = 'N') AND 
                                                                                                 (MAT_TYPE IN (SELECT MAT_TYPE FROM PIP_MAT_TYPE WHERE MAT_GROUP =:WO_Mat) OR :WO_Mat='XX')
                                                                    
        ORDER BY SPL_TITLE">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJ_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="ddSFR" DefaultValue="XXX" Name="SFR" PropertyName="SelectedValue" />

            <asp:ControlParameter ControlID="AnySize_HiddenField" DefaultValue="N" Name="ALL_SIZE" PropertyName="Value" />
            <asp:ControlParameter ControlID="txtIsometric" DefaultValue="%" Name="ISO_TITLE1" PropertyName="Text" />
            <asp:ControlParameter ControlID="scIdField" DefaultValue="-1" Name="SML_SC" PropertyName="Value" />
            <asp:ControlParameter ControlID="WO_Mat" DefaultValue="-1" Name="WO_Mat" PropertyName="Value" />
            <asp:ControlParameter ControlID="rcbSize" DefaultValue="-1" Name="RANGE" PropertyName="SelectedValue" />

        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SizeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT RANGE_B FROM PIP_SIZE_DESCR"></asp:SqlDataSource>
    <asp:SqlDataSource ID="splDwnDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"></asp:SqlDataSource>
    <asp:UpdatePanel runat="server" ID="upd1">
        <ContentTemplate>
            <asp:HiddenField ID="scIdField" runat="server" />
            <asp:HiddenField ID="WO_Mat" runat="server" />
            <asp:HiddenField ID="AnySize_HiddenField" runat="server" Value="N" />
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
