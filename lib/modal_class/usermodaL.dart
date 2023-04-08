class userdatamodal {
  String? status;
  List<BlockedSize>? blockedSize;

  userdatamodal({this.status, this.blockedSize});

  userdatamodal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['blocked_size'] != null) {
      blockedSize = <BlockedSize>[];
      json['blocked_size'].forEach((v) {
        blockedSize!.add(new BlockedSize.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.blockedSize != null) {
      data['blocked_size'] = this.blockedSize!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BlockedSize {
  String? xsBlock;
  String? sBlock;
  int? mBlock;
  int? lBlock;
  int? xlBlock;
  int? xxlBlock;
  int? i3xlBlock;
  int? i4xlBlock;
  int? i5xlBlock;

  BlockedSize(
      {this.xsBlock,
        this.sBlock,
        this.mBlock,
        this.lBlock,
        this.xlBlock,
        this.xxlBlock,
        this.i3xlBlock,
        this.i4xlBlock,
        this.i5xlBlock});

  BlockedSize.fromJson(Map<String, dynamic> json) {
    xsBlock = json['xs_block'];
    sBlock = json['s_block'];
    mBlock = json['m_block'];
    lBlock = json['l_block'];
    xlBlock = json['xl_block'];
    xxlBlock = json['xxl_block'];
    i3xlBlock = json['3xl_block'];
    i4xlBlock = json['4xl_block'];
    i5xlBlock = json['5xl_block'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['xs_block'] = this.xsBlock;
    data['s_block'] = this.sBlock;
    data['m_block'] = this.mBlock;
    data['l_block'] = this.lBlock;
    data['xl_block'] = this.xlBlock;
    data['xxl_block'] = this.xxlBlock;
    data['3xl_block'] = this.i3xlBlock;
    data['4xl_block'] = this.i4xlBlock;
    data['5xl_block'] = this.i5xlBlock;
    return data;
  }
}