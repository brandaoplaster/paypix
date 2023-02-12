require "date"
require "json"

class Charge
  attr_accessor :amount, :payer, :pix_account_id, :txid, :expire_at, :message, :additional_info

  def initialize(attributes, payer, additional_info)
    @amount = attributes[:amount]
    @payer = payer
    @pix_account_id = attributes[:pix_account_id]
    @txid = attributes[:txid]
    @expire_at = attributes[:expire_at]
    @message = attributes[:message]
    @additional_info = additional_info

    validation_required_fields
  end

  def to_json
    to_h.to_json
  end

  private

  def validation_required_fields
    raise ArgumentError, "amount is required" if @amount.nil?
    raise ArgumentError, "expire_at is required" if @expire_at.nil?
    raise ArgumentError, "pix_account_id is required" if @pix_account_id.nil?
  end

  def to_h
    {
      amount: amount,
      payer: payer,
      pix_account_id: pix_account_id,
      txid: txid,
      expire_at: expire_at,
      message: message,
      additional_info: additional_info,
    }
  end

  def parse_to_datetime(expire_at)
    DateTime.parse(expire_at)
  end
end
