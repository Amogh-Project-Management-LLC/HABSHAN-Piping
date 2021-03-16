<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="WelderProducJoints.aspx.cs" Inherits="WeldingInspec_WelderProducJoints"
    Title="Production Joints" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
            //<![CDATA[
            window.onresize = Test;
            Sys.Application.add_load(Test);
            function Test() {
                var grid = $find('<%= jointsGridView.ClientID %>')
                var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
                var width = document.getElementById("grad").clientWidth - document.getElementById("navigation_left").clientWidth;

                grid.get_element().style.height = (height) - 200 + "px";
                grid.get_element().style.width = width - 20 + "px";
                grid.get_element()
                grid.repaint();
            }
</script>
    <div style="background-color: gainsboro;">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnAuto" runat="server" Text="Auto Select Production Joints" Width="200" OnClick="btnAuto_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnEntry" runat="server" Text="New" Width="80" OnClick="btnEntry_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnRegister" runat="server" Text="Save" Width="80" OnClick="btnRegister_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <table id="EntryTable" runat="server" visible="false">
            <tr>
                <td style="width: 100px; background-color: whitesmoke">Isometric
                </td>
                <td>
                    <telerik:RadTextBox ID="txtIsome" runat="server" AutoPostBack="True" Width="200px"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="IsomeValidator" runat="server" ControlToValidate="txtIsome"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 100px; background-color: whitesmoke">Joint No
                </td>
                <td>
                    <telerik:RadDropDownList ID="cboJoints" runat="server" AppendDataBoundItems="True" DataSourceID="JointsDataSource"
                        DataTextField="JNT_TITLE" DataValueField="JOINT_ID" Width="250px" OnDataBinding="cboJoints_DataBinding">
                        <Items>
                            <telerik:DropDownListItem Text="(Select)" Value="-1" Selected="true" />
                        </Items>
                    </telerik:RadDropDownList>
                    <asp:CompareValidator ID="jointsValidator" runat="server" ControlToValidate="cboJoints"
                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="(Select)" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 100px; background-color: whitesmoke">Select By
                </td>
                <td>
                    <telerik:RadTextBox ID="txtSelBy" runat="server" Width="100px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 100px; background-color: whitesmoke">Remarks
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRemarks" runat="server" Width="350px"></telerik:RadTextBox>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="jointsGridView" runat="server" AutoGenerateColumns="False" SkinID="GridViewSkin" AllowFilteringByColumn="true" PagerStyle-AlwaysVisible="true" AllowPaging="true" PageSize="50"
            DataKeyNames="JOINT_ID,WELDER_ID" DataSourceID="prodJntsDataSource" Width="100%" AllowAutomaticDeletes="true" AllowAutomaticUpdates="true" OnItemDataBound="jointsGridView_ItemDataBound">
            <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true"></ClientSettings>
            <MasterTableView EditMode="InPlace" DataSourceID="prodJntsDataSource" DataKeyNames="JOINT_ID,WELDER_ID">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                        <ItemStyle CssClass="MyImageButton" Width="10px" />
                    </telerik:GridEditCommandColumn>

                    <telerik:GridButtonColumn ConfirmText="Delete this Job Card?" ConfirmDialogType="RadWindow"
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                        UniqueName="DeleteColumn">
                        <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" Width="10px" />
                    </telerik:GridButtonColumn>
                     <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="PDF">
                        <ItemTemplate>
                            <asp:Label ID="pdf" runat="server" Text=""></asp:Label>
                        </ItemTemplate>
                          <ItemStyle Width="40px" />
                        <HeaderStyle Width="40px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="ISO_TITLE1" HeaderText="ISOMETRIC" SortExpression="ISO_TITLE1" ReadOnly="true" AutoPostBackOnFilter="true"/>
                    <telerik:GridBoundColumn DataField="JOINT_NO" HeaderText="JOINT NO" SortExpression="JOINT_NO" ReadOnly="true" AutoPostBackOnFilter="true"/>
                    <telerik:GridBoundColumn DataField="JNT_REV_CODE" HeaderText="REV CODE" SortExpression="JNT_REV_CODE" ReadOnly="true" />
                    <telerik:GridBoundColumn DataField="WELD_DATE" DataFormatString="{0:dd-MMM-yyyy}"
                        HeaderText="WELD DATE" HtmlEncode="False" SortExpression="WELD_DATE" ReadOnly="true" />
                    <telerik:GridBoundColumn DataField="NDE_REP_NO" HeaderText="NDE REPORT NO" SortExpression="NDE_REP_NO" ReadOnly="true" AutoPostBackOnFilter="true" />
                    <telerik:GridBoundColumn DataField="NDE_DATE" HeaderText="NDE DATE" SortExpression="NDE_DATE" ReadOnly="true" DataFormatString="{0:dd-MMM-yyyy}"/>
                    <telerik:GridBoundColumn DataField="PASS_FLG" HeaderText="NDE RESULT" SortExpression="PASS_FLG" ReadOnly="true" />
                    <telerik:GridBoundColumn DataField="SELECT_BY" HeaderText="Select By" SortExpression="SELECT_BY" ReadOnly="true" />
                    <telerik:GridBoundColumn DataField="REMARKS" HeaderText="REMARKS" SortExpression="REMARKS" />
                </Columns>
            </MasterTableView>
            <GroupingSettings CaseSensitive="false">                 
            </GroupingSettings>
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="prodJntsDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsWeldersTableAdapters.PIP_WELDER_PROD_JNTSTableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_WELDER_ID" Type="Decimal" />
            <asp:Parameter Name="original_JOINT_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="WELDER_ID" QueryStringField="WELDER_ID"
                Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_WELDER_ID" Type="Decimal" />
            <asp:Parameter Name="original_JOINT_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="jointsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT JOINT_ID, JNT_TITLE FROM VIEW_JOINT_TITLE_WELDERS WHERE (PROJ_ID = :PROJECT_ID) AND (ISO_TITLE1 = :ISO_TITLE1) AND (WELDER_ID = :WELDER_ID) ORDER BY JNT_TITLE">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="txtIsome" DefaultValue="XYZW" Name="ISO_TITLE1" PropertyName="Text" />
            <asp:QueryStringParameter DefaultValue="-1" Name="WELDER_ID" QueryStringField="WELDER_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="WELDER_CODE_HiddenField" runat="server" />
</asp:Content>
