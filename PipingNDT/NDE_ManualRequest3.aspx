<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="NDE_ManualRequest3.aspx.cs" Inherits="PipingNDT_NDE_ManualRequest" Title="NDT Request" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .MyRowClass {
            background-color: red;
        }

        .MyRowClass2 {
            background-color: green;
        }


    </style>
    <div style="background-color: whitesmoke;">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" OnClick="btnBack_Click" Width="80"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnAdd" runat="server" Text="Add to Request" OnClick="btnAdd_Click" Width="120"></telerik:RadButton>
                </td>


            </tr>
        </table>
    </div>
    <div>
       
                <table style="width: 100%">
                    <tr>
                        <td style="width: 30%">
                            <telerik:RadLabel Text="Line No" ID="lblLine" runat="server"></telerik:RadLabel>
                            <telerik:RadComboBox ID="rcbLineNO" runat="server" CausesValidation="false" Width="250px" DataSourceID="LINEDataSource" DataValueField="line_no" DataTextField="line_no"
                                AppendDataBoundItems="true" CheckBoxes="true" AllowCustomText="true" Filter="Contains" EnableCheckAllItemsCheckBox="true" AutoPostBack="true" OnSelectedIndexChanged="ddlLineNo_SelectedIndexChanged">
                            </telerik:RadComboBox>
                        </td>


                        <td style="width: 70%;">

                            <ul style="list-style: none;">

                                <li style=" float: left; margin-right: 10px;"><span  style="background-color: white;border: 1px solid #ccc; float: left; width: 30px; height: 15px; margin: 2px;"></span>Not Requested</li>
                                <li style=" float: left; margin-right: 10px;"><span  style="background-color: yellow;border: 1px solid #ccc; float: left; width: 30px; height: 15px; margin: 2px;"></span>Requested</li>
                                <li style=" float: left; margin-right: 10px;"><span style="background-color: lightgreen;border: 1px solid #ccc; float: left; width: 30px; height: 15px; margin: 2px;"></span>Accepted</li>
                                <li style=" float: left; margin-right: 10px;"><span style="background-color: red;border: 1px solid #ccc; float: left; width: 30px; height: 15px; margin: 2px;"></span>Rejected</li>
                                <li style=" float: left; margin-right: 10px;"><span  style="background-color: lightcoral;border: 1px solid #ccc; float: left; width: 30px; height: 15px; margin: 2px;"></span>CRW/Repair</li>
                            </ul>

                        </td>
                    </tr>
                </table>
         <asp:UpdatePanel runat="server" ID="updatepanel">
            <ContentTemplate>
                <table style="width: 100%">

                    <tr>
                        <td style="width: 50%">
                            <telerik:RadListBox ID="From_Joints" runat="server" Width="100%" Height="200px" SelectionMode="Multiple" AllowTransfer="True" TransferToID="To_Joints"
                                DataTextField="JNT_TITLE" DataValueField="JOINT_ID" AutoPostBack="true" OnDataBound="From_Joints_DataBound" >
                            </telerik:RadListBox>
                        </td>
                        <td style="width: 50%">
                            <telerik:RadListBox ID="To_Joints" runat="server" Width="100%" Height="200px" SelectionMode="Multiple"></telerik:RadListBox>
                        </td>
                    </tr>

                </table>


                </div>

    <div>

        <telerik:RadGrid ID="lineGrid" runat="server" AutoGenerateColumns="true" PageSize="10">
            <ClientSettings>
                <Scrolling AllowScroll="true" />
            </ClientSettings>

        </telerik:RadGrid>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>


    <asp:SqlDataSource ID="LINEDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT DISTINCT LINE_NO
                       FROM VIEW_NDE_MANUAL_REQUEST_JNTS
                       WHERE PROJ_ID = :PROJECT_ID AND
                        (((CAT_ID = 1 OR  CAT_ID = 3) AND SC_ID = :SC_ID AND WO_ID IS NOT NULL)
                                OR ((CAT_ID = 2 OR CAT_ID = 4) AND FIELD_SC_ID = :SC_ID))
                          AND  (
                                  ((:NDE_TYPE_ID=1 OR :NDE_TYPE_ID=12) AND RT1_REQRD &gt; 0 AND RT1_RQSTD &lt; 1) OR
                                  ((:NDE_TYPE_ID=2 OR :NDE_TYPE_ID=13) AND RT2_REQRD &gt; 0 AND RT2_RQSTD &lt; 1) OR
                                  (:NDE_TYPE_ID=3 AND  PT_REQRD &gt; 0 AND PT_RQSTD &lt; 1) OR
                                  (:NDE_TYPE_ID=5 AND MT_REQRD &gt; 0 AND MT_RQSTD &lt; 1) OR
                                  (:NDE_TYPE_ID=7 AND PWHT_REQRD &gt; 0 AND PWHT_RQSTD &lt; 1) OR
                                  (:NDE_TYPE_ID=9 AND PMI_REQRD &gt; 0 AND PMI_RQSTD &lt; 1) OR
                                  (:NDE_TYPE_ID=8 AND HT_REQRD &gt; 0 AND HT_RQSTD &lt; 1) OR
                                  (:NDE_TYPE_ID=10 AND FT_REQRD &gt; 0 AND FT_RQSTD &lt; 1)
                               )
                        ">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:QueryStringParameter DefaultValue="-1" Name="SC_ID" QueryStringField="SC_ID" />
            <asp:QueryStringParameter DefaultValue="-1" Name="NDE_TYPE_ID" QueryStringField="NDE_TYPE_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="jntsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT ISO_TITLE1||'/'||SPOOL||'/'||JOINT_NO||'/'||CRW_CODE AS JNT_TITLE,JOINT_ID
                       FROM VIEW_NDE_MANUAL_REQUEST_JNTS
                       WHERE PROJ_ID = :PROJECT_ID AND
                        (((CAT_ID = 1 OR  CAT_ID = 3) AND SC_ID = :SC_ID AND WO_ID IS NOT NULL)
                                OR ((CAT_ID = 2 OR CAT_ID = 4) AND FIELD_SC_ID = :SC_ID))
                          AND  (
                                  ((:NDE_TYPE_ID=1 OR :NDE_TYPE_ID=12) AND RT1_REQRD &gt; 0 AND RT1_RQSTD &lt; 1) OR
                                  ((:NDE_TYPE_ID=2 OR :NDE_TYPE_ID=13) AND RT2_REQRD &gt; 0 AND RT2_RQSTD &lt; 1) OR
                                  (:NDE_TYPE_ID=3 AND  PT_REQRD &gt; 0 AND PT_RQSTD &lt; 1) OR
                                  (:NDE_TYPE_ID=5 AND MT_REQRD &gt; 0 AND MT_RQSTD &lt; 1) OR
                                  (:NDE_TYPE_ID=7 AND PWHT_REQRD &gt; 0 AND PWHT_RQSTD &lt; 1) OR
                                  (:NDE_TYPE_ID=9 AND PMI_REQRD &gt; 0 AND PMI_RQSTD &lt; 1) OR
                                  (:NDE_TYPE_ID=8 AND HT_REQRD &gt; 0 AND HT_RQSTD &lt; 1) OR
                                  (:NDE_TYPE_ID=10 AND FT_REQRD &gt; 0 AND FT_RQSTD &lt; 1)
                                )
                        
                       ">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:QueryStringParameter DefaultValue="-1" Name="SC_ID" QueryStringField="SC_ID" />
            <asp:QueryStringParameter DefaultValue="-1" Name="NDE_TYPE_ID" QueryStringField="NDE_TYPE_ID" />

        </SelectParameters>
    </asp:SqlDataSource>
    <%--  <telerik:RadAjaxManager ID="RadAjaxManager" runat="server" EnableAJAX="true" DefaultLoadingPanelID="RadAjaxLoadingPanel1">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="ddlLineNo">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="From_Joints" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="ddlLineNo" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />--%>
    <asp:HiddenField ID="hiddenLineNo" runat="server" />

    <asp:SqlDataSource ID="LineWiseDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>">
        <%--  <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
          
        </SelectParameters>--%>
    </asp:SqlDataSource>
</asp:Content>
